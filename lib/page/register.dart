import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geprek_alhamdulillah/page/login.dart';
import 'package:geprek_alhamdulillah/service/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:progress_dialog/progress_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerKonfirmasi = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  Future<bool> register() async {
    ProgressDialog pg = new ProgressDialog(context, isDismissible: false);
    pg.style(message: "Register...");
    pg.show();
    String url =Server.register;
    if (_controllerUsername.text.isEmpty ||
        _controllerEmail.text.isEmpty ||
        _controllerPassword.text.isEmpty ||
        _controllerKonfirmasi.text.isEmpty) {
         
      _globalKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Field is not empty"),
      ));
      return false;
      pg.dismiss();
      Navigator.pop(context);
    } else {
       pg.dismiss();
      await http.post(url, body: {
        "username": "${_controllerUsername.text}",
        "nama_pembeli": "${_controllerUsername.text}",
        "alamat": "${_controllerAlamat.text}",
        "password": "${_controllerPassword.text}"
      }).then((response) {
        print(response.body);
        pg.dismiss();
        if (response.statusCode == 200) {
          String message = convert.jsonDecode(response.body)['message'];
          Flushbar(
            animationDuration: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 1000),
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: false,
            messageText: Text("Berhasil Register"),
          )..show(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        }else{
          Flushbar(
            animationDuration: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 1000),
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: false,
            messageText: Text("gagal Register"),
          )..show(context);
        }
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 150,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
                child: TextField(
                  controller: _controllerUsername,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      prefixStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                      hintText: "Username",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: TextField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      prefixStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: TextField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      prefixStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                      hintText: "Password",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: TextField(
                  controller: _controllerKonfirmasi,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      prefixStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                      hintText: "Konfirmasi Password",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: TextField(
                  controller: _controllerAlamat,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.streetview),
                      prefixStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                      hintText: "Alamat",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RaisedButton(
                  child: Text('Daftar'),
                  color: Colors.blue,
                  splashColor: Colors.lightGreen,
                  onPressed: () {
                    register();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
