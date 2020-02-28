class Produk {
  int code;
  bool success;
  String message;
  List<Data> data;

  Produk({this.code, this.success, this.message, this.data});

  Produk.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String idProduk;
  String namaProduk;
  String jenisProduk;
  String keterangan;
  String harga;
  String gambar;

  Data(
      {this.idProduk,
      this.namaProduk,
      this.jenisProduk,
      this.keterangan,
      this.harga,
      this.gambar});

  Data.fromJson(Map<String, dynamic> json) {
    idProduk = json['id_produk'];
    namaProduk = json['nama_produk'];
    jenisProduk = json['jenis_produk'];
    keterangan = json['keterangan'];
    harga = json['harga'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_produk'] = this.idProduk;
    data['nama_produk'] = this.namaProduk;
    data['jenis_produk'] = this.jenisProduk;
    data['keterangan'] = this.keterangan;
    data['harga'] = this.harga;
    data['gambar'] = this.gambar;
    return data;
  }
}
