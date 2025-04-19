import 'package:flutter/material.dart';

class Item {
  final String name;
  final String description;
  final String image;

  Item({required this.name, required this.description, required this.image});
}

class Inventory extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}
