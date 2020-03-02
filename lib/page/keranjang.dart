import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:geprek_alhamdulillah/model/keranjang.dart';
import 'package:geprek_alhamdulillah/service/server.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class Keranjang extends StatefulWidget {
  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  List<Datum> listKeranjang = List<Datum>();
  PersistentBottomSheetController _controller;
  ProgressDialog pg;
  int total = 0;
  bool isLoading=true;
  GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
      amount: 0,
      settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          compactFormatType: CompactFormatType.short));

  Future<bool> getKeranjang() async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    String url = Server.getKeranjang;
    await http.post(url, body: {"id_pembeli": "${pref.get("id")}"}).then(
        (response) {
      if (response.statusCode == 200) {
        setState(() {
          isLoading=false;
        });
        listKeranjang.clear();

        List responseJson = convert.jsonDecode(response.body)['data'];
       if(responseJson.length!=0){
         total=0;
         for (int i = 0; i < responseJson.length; i++) {

           setState(() {
             total = total +
                 (int.parse(responseJson[i]['harga']) *
                     int.parse(responseJson[i]['jumlah']));
             listKeranjang.add(Datum(
                 harga: responseJson[i]['harga'],
                 idProduk: responseJson[i]['id_produk'],
                 idKeranjang: responseJson[i]['id_keranjang'],
                 jumlah: responseJson[i]['jumlah'],
                 idPembeli: responseJson[i]['id_pembeli'],
                 namaPembeli: responseJson[i]['nama_pembeli'],
                 namaProduk: responseJson[i]['nama_produk']));
           });
         }
         setState(() {
           fmf = new FlutterMoneyFormatter(
               amount: total.toDouble(),
               settings: MoneyFormatterSettings(
                   symbol: 'Rp',
                   thousandSeparator: '.',
                   decimalSeparator: ',',
                   symbolAndNumberSeparator: ' ',
                   fractionDigits: 0,
                   compactFormatType: CompactFormatType.short));
         });
       }else{
         setState(() {
           fmf = new FlutterMoneyFormatter(
               amount: 0,
               settings: MoneyFormatterSettings(
                   symbol: 'Rp',
                   thousandSeparator: '.',
                   decimalSeparator: ',',
                   symbolAndNumberSeparator: ' ',
                   fractionDigits: 0,
                   compactFormatType: CompactFormatType.short));
         });
       }



      }
    }, onError: (err) {
      print(err);
    });

    return true;
  }

  Future<bool> hapusKeranjang(String id_produk) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pg=new ProgressDialog(context,isDismissible: false);
    pg.style(
      message: "Loading"
    );
    pg.show();

    String url = Server.hapusKeranjang;
    await http.post(url, body: {"id_pembeli": "${pref.get("id")}",
    "id_produk": "$id_produk"}).then(
        (response) {
      if (response.statusCode == 200) {
        pg.dismiss();
        Flushbar(
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(milliseconds: 1000),
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: false,
          messageText: Text("Berhasil dihapus",style: TextStyle(color: Colors.white),),
        )..show(context);
        getKeranjang().then((response){
          pg.dismiss();
        });
      }
    }, onError: (err) {
      print(err);
    });

    return true;
  }
  bottommodal(context){
    showBottomSheet(
        context: context , builder: (BuildContext c){
      return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    getKeranjang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Keranjang"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : listKeranjang.length == 0 ? Center(child: Text("Laka Coy"),):ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: listKeranjang.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 4,
                    child: ListTile(
                      isThreeLine: true,
                      contentPadding: EdgeInsets.all(10),
                      leading: Image.asset(
                        "assets/logo.png",
                        height: 200,
                        width: 80,
                      ),
                      title: Text(listKeranjang[index].namaProduk),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(listKeranjang[index].harga),
                          SizedBox(
                            height: 5,
                          ),
                          Text(listKeranjang[index].jumlah)
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text((int.parse(listKeranjang[index].harga) *
                                  int.parse(listKeranjang[index].jumlah))
                              .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                bottommodal(context);
                              },
                              child: Icon(
                                Icons.delete,
                                size: 25,
                              )),
                        ],
                      ),
                    ));
              }),
      bottomNavigationBar: Container(
        height: 120,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 10.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Total Harga",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${fmf.output.symbolOnLeft}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () {
                    },
                    color: Colors.blueAccent,
                    child: Text(
                      "Pesan",
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 4, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
