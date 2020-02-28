import 'package:flutter/material.dart';
import 'package:geprek_alhamdulillah/model/produk.dart';
import 'package:geprek_alhamdulillah/page/keranjang.dart';
import 'package:geprek_alhamdulillah/service/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MenuUtama extends StatefulWidget {
  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  List<Data> listProduk=List<Data>();

  Future<bool> getProduk()async{

    String url=Server.menu_produk;
    await http.get(url).then((response){

      if(response.statusCode==200){
        listProduk.clear();

        List responseJson=convert.jsonDecode(response.body)['data'];
        for(int i=0;i<responseJson.length;i++){
          setState(() {
            listProduk.add(Data(
              harga: responseJson[i]['harga'],
              idProduk:  responseJson[i]['id_produk'],
              jenisProduk:  responseJson[i]['jenis_produk'],
              keterangan: responseJson[i]['keterangan'],
              namaProduk: responseJson[i]['nama_produk']
            ));
          });
        }

      }

    },onError: (err){
      print(err);
    });

    return true;
  }
  @override
  void initState() {
    getProduk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Keranjang())),
              padding: EdgeInsets.only(right: 20),
              icon: Icon(Icons.shopping_cart,size: 30,color: Colors.white,),
            )
          ],
        ),
          body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 40, right: 30),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Pencarian..",
                    suffix: Icon(
                      Icons.search,
                      size: 20,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Text(
                "Food Menu",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: 10),

              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: listProduk.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.asset(
                            "assets/logo.png",
                            height: 200,
                            width: 80,
                          ),
                          title: Text(listProduk[index].namaProduk),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(listProduk[index].harga),
                              SizedBox(height: 5,),
                              Text(listProduk[index].keterangan)
                            ],
                          ),
                          trailing: IconButton(icon: Icon(Icons.add,size: 25,color: Colors.blue,), onPressed: (){}),
                        ));

                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        height: 60,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          IconButton(icon: Icon(Icons.home,size: 30,), onPressed: (){},color: Colors.blue,),
          IconButton(icon: Icon(Icons.history,size: 30,), onPressed: (){},color: Colors.blue,),
          IconButton(icon: Icon(Icons.account_circle,size: 30,), onPressed: (){},color: Colors.blue,)
          ],
        ),
      ),),
    );
  }
}

class Items extends StatelessWidget {
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel,
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final String hotel;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(
                    left: leftAligned ? 20 : 0,
                    right: leftAligned ? 0 : 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(itemName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                            Text("\$$itemPrice",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                                children: [
                                  TextSpan(text: "by "),
                                  TextSpan(
                                      text: hotel,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700))
                                ]),
                          ),
                        ),
                        SizedBox(height: containerPadding),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}
