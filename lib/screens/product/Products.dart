import 'dart:convert';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'package:demo/services/Api.dart';
import 'package:http/http.dart' as http;
import 'package:demo/screens/product/ProductDetail.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProductsScreen();
  }
}

class ProductsScreen extends State<Products> {
  var _products = <Product>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _loadData() async {
    String dataUrl = API.products;
    http.Response response = await http.get(dataUrl);

    setState(() {
      final data = jsonDecode(response.body);
      final productsJSON = data['result'];
      for (var productJSON in productsJSON) {
        final product = new Product(
            productJSON["_id"],
            productJSON["name"],
            productJSON["description"],
            productJSON["price"],
            productJSON["quanty"]);
        _products.add(product);
      }
    });
  }

  _goToProductDetail(context, id) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ProductDetail(id: id)
      ),
    );
  }

  Widget _buildRow(BuildContext context, int i) {
    return new Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Image.asset(
            'images/product_none.jpeg',
            width: 380.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new GestureDetector(
            onTap: () {
              String id = _products[i].id;
              _goToProductDetail(context, id);
            },
            child: new Padding(
            padding: const EdgeInsets.all(2.0),
              child:new Text("${_products[i].name}", style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(2.0),
            child: new Text("${_products[i].price}", style: _biggerFont),
          ),
        ]
      )
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      body: _products.length > 0 ? new Container(
        margin: const EdgeInsets.only(top: 20.0),
          child: new ListView.builder(
            itemCount: _products.length * 2,
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final index = position ~/ 2;
              return _buildRow(context, index);
            }),
      ) : new Center(
        child: new CircularProgressIndicator(),
      )
    );
  }
}
