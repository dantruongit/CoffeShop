import json
from Security import Security
from datetime import datetime
from config import ip_server

sc = Security()

class User:
    def __init__(self, data: tuple):
        self.id = data[0]
        self.username = data[1]
        self.password = data[2]
        self.image = data[3]
        self.name = data[4]

    def generate_jwt(self):
        return sc.generate_jwt_key(self.id, self.username)
    
class Coffe:
    def __init__(self, data: tuple):
        self.id = data[0]
        self.title = data[1]
        self.image = str(data[2]).replace("localhost", ip_server)
        self.description = data[3]
        self.amount = data[4]
        self.isFavorite = False

    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "image": self.image,
            "description": self.description,
            "amount": self.amount,
            "isFavorite": self.isFavorite
        }

class CartItem:
    def __init__(self, id_coffe, quantity, data: Coffe):
        self.id_coffe = id_coffe
        self.quantity = quantity
        if data == None:
            self.coffe = {}
        else:
            self.coffe = data
            self.coffe.image = self.coffe.image.replace("localhost", ip_server)

    def to_dict(self):
        return {
            "id_coffe": self.id_coffe,
            "quantity": self.quantity,
            "coffe": self.coffe.to_dict()
        }
    
class Order:
    def __init__(self, data: tuple):
        self.id = data[0]
        self.id_user = data[1]
        self.amount = data[2]
        self.date_time = data[3]
        self.order_items = []
    
    def datetime_converter(self, o):
        if isinstance(o, datetime):
            return o.__str__()
        
    def to_dict(self):
        return {
            "id": self.id,
            "id_user": self.id_user,
            "amount": self.amount,
            "date_time": json.dumps(self.date_time, default= self.datetime_converter),
            "order_items": [order_item.to_dict() for order_item in self.order_items]
        }

    def add_order_item(self, order_item: CartItem):
        self.order_items.append(order_item)
    
class OrderItem:
    def __init__(self, data: tuple):
        self.id_order = data[0]
        self.id_coffe = data[1]
        self.quantity = data[2]
        self.price = data[3]
        self.coffe = Coffe(data[4:])
        self.coffe.image = self.coffe.image.replace("localhost", ip_server)
    
    def to_dict(self):
        return {
            "id_order": self.id_order,
            "id_coffe": self.id_coffe,
            "quantity": self.quantity,
            "price": self.price,
            "coffe": self.coffe.to_dict()
        }