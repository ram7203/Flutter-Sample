// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:first_app/models/catalog.dart';

class CartModel {
  late CatalogModel _catalog;

  final List<int> itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel new_catalog) {
    assert(new_catalog != null);
    _catalog = new_catalog;
  }

  //get items in the cart
  List<Item> get items => itemIds.map((id) => _catalog.getById(id)).toList();

  //get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //add item
  void add(Item item) {
    itemIds.add(item.id);
  }

  //remove item
  void remove(Item item) {
    itemIds.remove(item.id);
  }
}
