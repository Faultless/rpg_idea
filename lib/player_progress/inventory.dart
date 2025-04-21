import 'package:flutter/material.dart';

class Item {
  final String name;
  final String description;
  final String image;

  Item({required this.name, required this.description, required this.image});

  void action() {
    // Define the action to be performed when the item is used
    print('Using item: $name');
  }
}

class Inventory extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(int itemIdx) {
    if (itemIdx < 0 || itemIdx >= _items.length) {
      return; // Invalid index, do nothing
    }
    _items.removeAt(itemIdx);
    notifyListeners();
  }

  void use(Item item) {
    item.action();
    
    remove(_items.indexOf(item));
  }
}
