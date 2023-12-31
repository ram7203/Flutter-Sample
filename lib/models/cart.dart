// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:first_app/core/store.dart';
import 'package:first_app/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  //singleton class

  // static final cartModel = CartModel._internal();

  // CartModel._internal();

  // factory CartModel() => cartModel;

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
  // void add(Item item) {
  //   itemIds.add(item.id);
  // }

  //remove item
  // void remove(Item item) {
  //   itemIds.remove(item.id);
  // }
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);

  @override
  perform() {
    store?.cart.itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);

  @override
  perform() {
    store?.cart.itemIds.remove(item.id);
  }
}
