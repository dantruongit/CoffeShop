from flask import Flask, jsonify, request
from Service import *
app = Flask(__name__)
from flask_cors import CORS
from Security import Security

# Initialize CORS
CORS(app)
service = Service()

@app.route("/login", methods=["POST"])
def login():
    data = request.json
    username = data["username"]
    password = data["password"]
    user = service.check_login(username, password)[0]
    token = service.check_login(username, password)[1]

    if token != None:
        print("User: ", user)
        return jsonify({"isSuccess": True, "name": user.name, "image" : user.image ,"token": token})
    return jsonify({"error": "Invalid username or password"})

@app.route("/register", methods=["POST"])
def register():
    data = request.json
    username = data["username"]
    password = data["password"]
    fullname = data["fullName"]
    return jsonify({"isSuccess": service.addAccount(username, password, fullname)})


@app.route("/get_coffees", methods=["GET"])
def get_coffees():
    return jsonify(service.get_coffes())

@app.route("/get_user_cart", methods=["POST"])
def get_user_cart():
    data = request.json
    jwtKey = data["jwtKey"]
    return jsonify(service.getUserCart(jwtKey))

@app.route("/get_user_order", methods=["POST"])
def get_user_order():
    data = request.json
    jwtKey = data["jwtKey"]
    return jsonify(service.getUserOrder(jwtKey))

if __name__ == '__main__':
    app.run(debug=True, port = 12121)