import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geprek_alhamdulillah/page/list.dart';
import 'package:geprek_alhamdulillah/page/register.dart';
import 'package:geprek_alhamdulillah/service/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:progress_dialog/progress_dialog.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerUsername=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();



  Future<bool> login()async{
    ProgressDialog pg=new ProgressDialog(context,isDismissible:true );
    pg.style(
        message: "Mohon tunggu",

    );
    pg.show();
    String url=Server.login;
    await http.post(url,
    body: {
      'username' : "${_controllerUsername.text}",
      "password" : "${_controllerPassword.text}"
    }).then((response){
      pg.dismiss();
        if(response.statusCode==200){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MenuUtama()));
        }else{
          Flushbar(
            animationDuration: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 1000),
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: false,
            messageText: Text("gagal login"),
          )..show(context);
        }
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          body: SingleChildScrollView(
                      child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/logo.png",width: 150,),
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: _controllerUsername,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                      hintText: "Masukkan Username atau Email anda",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: _controllerPassword,
                    decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                    hintText: "Masukkan Password anda",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    )
                    ),
                ),
                 Container(
                  height: 30.0,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text(
                      "Lupa Password?"
                      ),
                      onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    splashColor: Colors.lightGreen,
                    onPressed: (){
                     login(); 
                    },
                  ),
                ),
                Container(
                  height: 30.0,
                  alignment: Alignment.topCenter,
                  child: FlatButton(
                    
                    child: Text(
                      "Belum memiliki akun? Register"
                    ),
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>Register())),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}