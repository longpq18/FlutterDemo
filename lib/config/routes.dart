import 'package:flutter/material.dart';
import 'package:demo/screens/auth/Login.dart';
import 'package:demo/screens/home/Home.dart';
import 'package:demo/screens/product/Products.dart';

final routes = {
  '/' :     (BuildContext context) => new Login(),
  '/login': (BuildContext context) => new Login(),
  '/home':  (BuildContext context) => new Home(),
  '/products': (BuildContext context) => new Products(),
};