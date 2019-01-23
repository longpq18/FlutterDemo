import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:demo/services/Api.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  ProductDetail({Key key, this.id}) : super();

  @override
  State<StatefulWidget> createState() {
    return new ProductDetailScreen();
  }
}

class ProductDetailScreen extends State<ProductDetail> {
  var _product = [];

  _getProductDetail() async {
    String dataUrl = API.products;
    http.Response response = await http.get('${dataUrl}/${widget.id}');

    await setState(() {
      final data = jsonDecode(response.body);
      final productJSON = data['result'];
      _product.add(productJSON);
    });
  }

  @override
  void initState() {
    super.initState();

    _getProductDetail();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: _product.length > 0 ? Container(
            child: new Column(
              children: <Widget>[
                new Image.asset(
                  'images/product_none.jpeg',
                  width: 500,
                  height: 240.0,
                  fit: BoxFit.fitWidth,
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                      _product[0]['name']
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                      _product[0]['description']
                  ),
                )
              ],
            )
      ) : Center (
          child: new CircularProgressIndicator()
      ),
    );
  }
}
