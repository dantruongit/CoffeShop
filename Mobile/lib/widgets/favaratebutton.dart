import 'package:cofeeshop/provider/coffee.dart';
import 'package:flutter/material.dart';
import 'package:cofeeshop/service/service.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';
 

class FavoriteButton extends StatefulWidget {
  final Coffee coffee;

  const FavoriteButton({super.key, required this.coffee});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return IconButton(
      onPressed: () {
        setState(() {
          widget.coffee.isFavarate = !widget.coffee.isFavarate;
          Service.gI().updateFavorite(user, widget.coffee.id);
        });
      },
      icon: Icon(
        widget.coffee.isFavarate ? Icons.favorite : Icons.favorite_border,
        color: widget.coffee.isFavarate ? Colors.red : Colors.white,
      ),
    );
  }
}
