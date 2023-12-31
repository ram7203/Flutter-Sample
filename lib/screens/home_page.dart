import 'package:first_app/core/store.dart';
import 'package:first_app/models/cart.dart';
import 'package:first_app/models/catalog.dart';
import 'package:first_app/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'home_widgets/catalog_header.dart';
import 'home_widgets/catalog_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");

    // final response = await http.get(Uri.parse(url));

    // final catalogJson = response.body;

    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    // final dummyList = List.generate(10, (index) => CatalogModel.items[0]);

    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
        builder: (context, x, y) => FloatingActionButton(
          // ignore: deprecated_member_use
          backgroundColor: Theme.of(context).backgroundColor,
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
          child: Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ).badge(
          color: Vx.red500,
          size: 20,
          count: _cart.items.length,
        ),
        mutations: {AddMutation, RemoveMutation},
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Catalog App"),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     // child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
    //     //     ? ListView.builder(
    //     //         itemCount: CatalogModel.items.length,
    //     //         itemBuilder: (context, index) {
    //     //           return ItemWidget(
    //     //             item: CatalogModel.items[index],
    //     //           );
    //     //         },
    //     //       )
    //     //     : Center(
    //     //         child: CircularProgressIndicator(),
    //     //       ),
    //     child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
    //         ? GridView.builder(
    //             itemCount: CatalogModel.items.length,
    //             itemBuilder: (context, index) {
    //               final item = CatalogModel.items[index];
    //               return Card(
    //                   clipBehavior: Clip.antiAlias,
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(15)),
    //                   child: GridTile(
    //                     header: Container(
    //                       child: Text(
    //                         item.name,
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                       decoration: BoxDecoration(
    //                         color: Colors.deepPurple,
    //                       ),
    //                       padding: EdgeInsets.all(12),
    //                     ),
    //                     child: Image.network(
    //                       item.image,
    //                     ),
    //                     footer: Container(
    //                       child: Text(
    //                         item.price.toString(),
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                       decoration: BoxDecoration(
    //                         color: Colors.black,
    //                       ),
    //                       padding: EdgeInsets.all(12),
    //                     ),
    //                   ));
    //             },
    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2,
    //                 mainAxisSpacing: 16,
    //                 crossAxisSpacing: 16),
    //           )
    //         : Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //   ),
    //   drawer: MyDrawer(),
    // );
  }
}
