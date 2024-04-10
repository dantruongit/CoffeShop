from flask import Flask, jsonify, request
from Service import Service
app = Flask(__name__)
from flask_cors import CORS
from Security import Security
from config import ip_server

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
        return jsonify({"isSuccess": True, "name": user.name, "image" : str(user.image).replace("localhost", ip_server) ,"token": token})
    return jsonify({"error": "Invalid username or password"})

@app.route("/register", methods=["POST"])
def register():
    data = request.json
    username = data["username"]
    password = data["password"]
    fullname = data["fullName"]
    return jsonify({"isSuccess": service.addAccount(username, password, fullname)})


@app.route("/get_coffees", methods=["POST"])
def get_coffees():
    data = request.json
    jwtKey = data["jwtKey"]
    coffees = service.get_coffes(jwtKey)
    for coffe in coffees:
        coffe["image"] = str(coffe["image"]).replace("localhost", ip_server)
    return jsonify(coffees)

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

@app.route("/get_user_balance", methods=["POST"])
def get_user_balance():
    data = request.json
    jwtKey = data["jwtKey"]
    return jsonify(service.getUserBalance(jwtKey))

@app.route("/update_favorite", methods=["POST"])
def update_favorite():
    data = request.json
    jwtKey = data["jwtKey"]
    id_coffe = data["id_coffe"]
    return jsonify(service.removeFavorite(jwtKey, id_coffe))

@app.route("/change_password", methods=["POST"])
def change_password():
    data = request.json
    jwtKey = data["jwtKey"]
    newPassword = data["newPassword"]
    return jsonify({
        "isSuccess": service.changePassword(jwtKey, newPassword)
    })

@app.route("/remove_cart", methods=["POST"])
def remove_cart():
    data = request.json
    jwtKey = data["jwtKey"]
    id_coffe = data["id_coffe"]
    print("id_coffe removed: ", id_coffe)
    return jsonify({
        "isSuccess": service.removeItemInCart(jwtKey, id_coffe)
    })

@app.route("/place_order", methods=["POST"])
def place_order():
    data = request.json
    jwtKey = data["jwtKey"]
    return jsonify({
        "isSuccess": service.placeOrder(jwtKey)
    })

@app.route("/add_to_cart", methods=["POST"])
def add_to_cart():
    data = request.json
    jwtKey = data["jwtKey"]
    coffees = data["coffees"]
    result = service.addCoffeToCart(jwtKey, coffees)
    print("coffees added: ", coffees)
    return jsonify({
        "isSuccess": result
    })

if __name__ == '__main__':
    app.run(host = "0.0.0.0",debug=True, port = 12121)