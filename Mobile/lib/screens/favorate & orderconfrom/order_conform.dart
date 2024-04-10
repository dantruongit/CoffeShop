import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cofeeshop/constants.dart';
import 'package:cofeeshop/provider/cart.dart';
import '../../provider/orders.dart';
import '../../provider/user.dart';
import '../../service/service.dart';
import '../../widgets/product_tile.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = '/order_confirmation';

  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final List<CartItems> items = args['items'];
    final double totalAmount = args['totalAmount'];
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Thank for Your order\n',
                    style: TextStyle(
                        color: klightgrycolor,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                    children: const [
                      TextSpan(
                          text: '\nPlease confirm the Order for Payment',
                          style: TextStyle(fontSize: 15))
                    ])),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductTile(
                    leadingImage: items[i].image,
                    subtitile: '${items[i].quantity}  x  '
                        '\$${items[i].amount.toStringAsFixed(2)}',
                    title: items[i].title,
                    trailing:
                        '\$ ${(items[i].quantity * items[i].amount).toStringAsFixed(2)}'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total  :   \$ ${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: klightgrycolor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: kaccentcolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.25,
                    vertical: 15)),
            onPressed: () async {
              int statusCode = await Service.gI().placeOrder(user);
              switch(statusCode){
                case 1:{
                  Provider.of<Orders>(context, listen: false)
                      .addOrders(cart.items.values.toList(), cart.totalAmount);
                  items.clear();
                  cart.clear();
                  Service.gI().getUserBalance(user);
                  Navigator.of(context).pop();
                  break;
                }
                case 0:{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Số dư không đủ để thanh toán !'),
                      duration: Duration(seconds: 2), // Thời gian hiển thị thông báo
                    ),
                  );
                  break;
                }
                case -1:{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Có lỗi trong quá trình thanh toán!'),
                      duration: Duration(seconds: 2), // Thời gian hiển thị thông báo
                    ),
                  );
                  break;
                }
              }
            },
            child: const Text(
              'Place Order',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
