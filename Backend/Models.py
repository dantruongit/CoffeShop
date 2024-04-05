import json
from Security import Security
from datetime import datetime

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
        self.image = data[2]
        self.description = data[3]
        self.amount = data[4]
    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "image": self.image,
            "description": self.description,
            "amount": self.amount
        }

class CartItem:
    def __init__(self, data: tuple):
        self.id_user = data[0]
        self.id_coffe = data[1]
        self.quantity = data[2]
        self.coffe = Coffe(data[3:])
    def to_dict(self):
        return {
            "id_user": self.id_user,
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
    
    def to_dict(self):
        return {
            "id_order": self.id_order,
            "id_coffe": self.id_coffe,
            "quantity": self.quantity,
            "price": self.price,
            "coffe": self.coffe.to_dict()
        }