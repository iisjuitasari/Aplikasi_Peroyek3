import 'package:flutter/material.dart';

class Keranjang extends StatefulWidget {
  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
      ),
      body:  ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: 2,
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
                  title: Text("sadfafas"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("safsdf"),
                      SizedBox(height: 5,),
                      Text("asfsdfg")
                    ],
                  ),
                  trailing: IconButton(icon: Icon(Icons.add,size: 25,color: Colors.blue,), onPressed: (){}),
                ));

          }),
    );
  }
}
