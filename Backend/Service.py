import json
from DataSource import DataSource
from Security import Security
from Models import *

sc = Security()

class Service:
    def __init__(self):
        self.ds = DataSource()
    
    #Authenciation
    def check_login(self, username: str, password: str):
        user = self.ds.get_user(username, password)
        if user != None:
            return [user, sc.generate_jwt_key(user.id, user.username, user.image, user.name)]
        return [None, None]
    
    def check_jwt(self, token: str) -> bool:
        return sc.validate_jwt_key(token) != None
    
    def addAccount(self, username: str, password: str, fullname: str) -> bool:
        return self.ds.add_user(username, password, fullname)
    
    def getFavoriteCoffes(self, jwtKey: str) -> list:
        favorites = []
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select favorite from User where id = '{idUser}'"
            data = self.ds.sql.execute_query(query)[0]
            favorites = json.loads(data[0])
        return favorites
    
    def removeFavorite(self, jwtKey: str, id_coffe: int) -> bool:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            favorites = self.getFavoriteCoffes(jwtKey)
            try:
                if id_coffe in favorites:
                    favorites.remove(id_coffe)
                else:
                    favorites.append(id_coffe)
            except:
                pass
            query = f"update User set favorite = '{json.dumps(favorites)}' where id = '{idUser}'"
            self.ds.sql.execute_insert_query(query)
            return True
        return False
    
    def changePassword(self, jwtKey: str, newPassword: str) -> bool:
        userInfo = sc.validate_jwt_key(jwtKey)
        if newPassword.isalnum() == False:
            return False
        
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"update User set password = '{newPassword}' where id = '{idUser}'"
            self.ds.sql.execute_insert_query(query)
            return True
        
        return False
    
    #Product
    def get_coffes(self, jwtKey: str) -> list:
        query = "select * from Coffe"
        coffees = []
        favorites = self.getFavoriteCoffes(jwtKey)
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            for cf_data in self.ds.sql.execute_query(query):
                cf = Coffe(cf_data)
                cf.isFavorite = cf.id in favorites
                coffees.append(cf.to_dict())
        return coffees
    
    def getCart(self, jwtKey: str) -> list:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select cart from User where id = '{idUser}'"
            cart = list(json.loads(self.ds.sql.execute_query(query)[0][0]))
            return cart
        return []

    def addCoffeToCart(self, jwt, coffees):
        userInfo = sc.validate_jwt_key(jwt)
        if userInfo == None:
            return False
        id_user = userInfo["id"]
        queryUpdate = f"update User set cart = '{(coffees)}' where id = '{id_user}'"
        self.ds.sql.execute_insert_query(queryUpdate)
        return True

    def removeCoffeFromCart(self, id_user, id_coffe):
        query = f"select cart from User where id = '{id_user}'"
        cart = list(json.loads(self.ds.sql.execute_query(query)[0][0]))
        for i in range(len(cart)):
            if cart[i]["id_coffee"] == id_coffe:
                cart.pop(i)
                break
        queryUpdate = f"update User set cart = '{json.dumps(cart)}' where id = '{id_user}'"
        self.ds.sql.execute_insert_query(queryUpdate)
        print("cart", cart)
        pass
    

    def removeItemInCart(self, jwtKey, id_coffe):
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            self.removeCoffeFromCart(idUser, id_coffe)
            return True
        return False
    
    def placeOrder(self, jwtKey: str) -> int:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select cart from User where id = '{idUser}'"
            cart = json.loads(self.ds.sql.execute_query(query)[0][0])
            total = 0
            for cart_data in cart:
                id_coffe = cart_data["id_coffee"]
                quantity = cart_data["quantity"]
                queryCoffe = f"select amount from Coffe where id = '{id_coffe}'"
                amount = self.ds.sql.execute_query(queryCoffe)[0][0]
                total += amount * quantity
            currentMoney = self.getUserBalance(jwtKey)["balance"]
            print("total", total)
            print("currentMoney", currentMoney)
            if total > currentMoney:
                return 0
            queryOrder = f"insert into Orders(id_user, amount) values('{idUser}', '{total}')"
            self.ds.sql.execute_insert_query(queryOrder)
            queryOrderId = f"select max(id) from Orders"
            orderId = self.ds.sql.execute_query(queryOrderId)[0][0]
            for cart_data in cart:
                id_coffe = cart_data["id_coffee"]
                quantity = cart_data["quantity"]
                queryOrderItem = f"insert into OrdersItem(id_order, id_coffe, quantity) values('{orderId}', '{id_coffe}', '{quantity}')"
                self.ds.sql.execute_insert_query(queryOrderItem)
            queryUpdate = f"update User set balance = '{currentMoney - total}',cart = '[]' where id = '{idUser}'"
            self.ds.sql.execute_insert_query(queryUpdate)
            return 1
        return -1

    # User
    def getUserCart(self, jwtKey: str) -> list:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select cart from User where id = '{idUser}'"
            cart = json.loads(self.ds.sql.execute_query(query)[0][0])
            cartItems = []
            for cart_data in cart:
                print("cart_data", cart_data)
                id_coffe = cart_data["id_coffee"]
                quantity = cart_data["quantity"]
                cartItem = CartItem(id_coffe=id_coffe, quantity=quantity, data=self.ds.get_coffe_by_id(id_coffe))
                cartItems.append(cartItem.to_dict())
            return {
                "cart": cartItems,
            }
        else:
            return {
                "error": "Invalid token",
                "cart": []
            }
    
    #   final List<CartItem> products;

    def getUserOrder(self, jwtKey: str) -> list:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select * from Orders where id_user = '{idUser}'"
            orders = []
            for order_data in self.ds.sql.execute_query(query):
                order = Order(order_data)
                queryOrderItem = f"select * from OrdersItem oi join Coffe cf on cf.id = oi.id_coffe where id_order = '{order.id}'"
                for order_data in self.ds.sql.execute_query(queryOrderItem):
                    orderItem = OrderItem(order_data)
                    order.add_order_item(orderItem)
                orders.append(order.to_dict())
            return {
                "orders": orders
            }
        else:
            return {
                "error": "Invalid token",
                "orders": []
            }
    
    def getUserBalance(self, jwtKey: str) -> dict:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select balance from User where id = '{idUser}'"
            balance = self.ds.sql.execute_query(query)[0][0]
            return {
                "balance": balance
            }
        else:
            return {
                "error": "Invalid token",
                "balance": 0.0
            }
    