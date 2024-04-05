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
        userInfo = sc.validate_jwt_key(token)
        return sc.validate_jwt_key(token) != None
    
    def addAccount(self, username: str, password: str, fullname: str) -> bool:
        return self.ds.add_user(username, password, fullname)
    
    #Product
    def get_coffes(self) -> list:
        query = "select * from Coffe"
        coffees = []
        for cf_data in self.ds.sql.execute_query(query):
            cf = Coffe(cf_data)
            coffees.append(cf.to_dict())
        return coffees
    
    def addCoffeToCart(self, id_user, id_coffe):
        query = f"insert into UserCart(id_user, id_coffe, quantity) values('{id_user}', '{id_coffe}', 1)"
        self.ds.sql.execute_insert_query(query)
        pass

    def updateQuantityCoffeInCart(self, id_user, id_coffe):
        query = f"update UserCart set quantity = quantity + 1 where id_user = '{id_user}' and id_coffe = '{id_coffe}'"
        self.ds.sql.execute_insert_query(query)
        pass

    def removeCoffeFromCart(self, id_user, id_coffe):
        query = f"delete from UserCart where id_user = '{id_user}' and id_coffe = '{id_coffe}'"
        self.ds.sql.execute_insert_query(query)
        pass

    # User
    def getUserCart(self, jwtKey: str) -> list:
        userInfo = sc.validate_jwt_key(jwtKey)
        if userInfo != None:
            idUser = userInfo["id"]
            query = f"select * from UserCart uc join Coffe c on c.id = uc.id_coffe where id_user = '{idUser}'"
            cart = []
            for cart_data in self.ds.sql.execute_query(query):
                cartItem = CartItem(cart_data)
                cart.append(cartItem.to_dict())
            return {
                "cart": cart,
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
    