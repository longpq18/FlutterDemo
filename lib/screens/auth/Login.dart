import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:demo/screens/product/Products.dart';
import 'package:http/http.dart' as http;
import 'package:demo/services/Api.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<Login> {
  bool isLoading = false;
  bool isLogin = false;
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  _showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Opps!"),
          content: new Text("Username or password is not correct"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List> _onLogin() async {
    _showLoading();

    await http.post(API.login,
      body: {
        "username": _username,
        "password": _password,
      }
    ).then((res) {
      var data = jsonDecode(res.body);
      if(data['success'] == true) {
        _hideLoading();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Products()),
        );
      } else {
        _hideLoading();
        _showDialog();
      }
    }).catchError((error) {
      print('ERROR $error');
      _hideLoading();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Opps!"),
            content: new Text("Error connect to server"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var loginBtn = new RaisedButton(
      onPressed: _onLogin,
      child: new Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Colors.black.withOpacity(0.5),

    );

    var loginForm = new Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            'Login Form',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0
            ),
          ),
        ),
        new Form(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextField(
                  onChanged: (String text) {
                    setState(() {
                      _username = text;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Username'
                  ),
                ),
              ),

              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextField(
                  onChanged: (String text) {
                    setState(() {
                      _password = text;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Password'
                  ),
                  obscureText: true,
                ),
              ),
              isLoading ? new CircularProgressIndicator() : loginBtn
            ],
          )
        )
      ],
    );

    return new Scaffold(
      appBar: null,
      body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("images/bg.jpeg"),
                fit: BoxFit.cover),
          ),
        child: new Center(
          child: new Container(
            child: loginForm,
            height: 260.0,
            width: 380.0,
            decoration: new BoxDecoration(
              color: Colors.white.withOpacity(0.5)
            ),
          ),
        )
      )
    );
  }
}