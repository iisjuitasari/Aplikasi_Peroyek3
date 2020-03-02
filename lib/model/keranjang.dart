// To parse this JSON data, do
//
//     final keranjang = keranjangFromJson(jsonString);

import 'dart:convert';

Keranjang keranjangFromJson(String str) => Keranjang.fromJson(json.decode(str));

String keranjangToJson(Keranjang data) => json.encode(data.toJson());

class Keranjang {
  int code;
  bool success;
  String message;
  List<Datum> data;

  Keranjang({
    this.code,
    this.success,
    this.message,
    this.data,
  });

  Keranjang copyWith({
    int code,
    bool success,
    String message,
    List<Datum> data,
  }) =>
      Keranjang(
        code: code ?? this.code,
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory Keranjang.fromJson(Map<String, dynamic> json) => Keranjang(
    code: json["code"],
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String idKeranjang;
  String idProduk;
  String idPembeli;
  String harga;
  String namaPembeli;
  String namaProduk;
  String jumlah;

  Datum({
    this.idKeranjang,
    this.idProduk,
    this.idPembeli,
    this.harga,
    this.namaPembeli,
    this.namaProduk,
    this.jumlah,
  });

  Datum copyWith({
    String idKeranjang,
    String idProduk,
    String idPembeli,
    String harga,
    String namaPembeli,
    String namaProduk,
    String jumlah,
  }) =>
      Datum(
        idKeranjang: idKeranjang ?? this.idKeranjang,
        idProduk: idProduk ?? this.idProduk,
        idPembeli: idPembeli ?? this.idPembeli,
        harga: harga ?? this.harga,
        namaPembeli: namaPembeli ?? this.namaPembeli,
        namaProduk: namaProduk ?? this.namaProduk,
        jumlah: jumlah ?? this.jumlah,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idKeranjang: json["id_keranjang"],
    idProduk: json["id_produk"],
    idPembeli: json["id_pembeli"],
    harga: json["harga"],
    namaPembeli: json["nama_pembeli"],
    namaProduk: json["nama_produk"],
    jumlah: json["jumlah"],
  );

  Map<String, dynamic> toJson() => {
    "id_keranjang": idKeranjang,
    "id_produk": idProduk,
    "id_pembeli": idPembeli,
    "harga": harga,
    "nama_pembeli": namaPembeli,
    "nama_produk": namaProduk,
    "jumlah": jumlah,
  };
}
