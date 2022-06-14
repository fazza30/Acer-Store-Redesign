part of 'model.dart';

class ItemProduk {
  int jumlah;
  final Produk? produk;

  ItemProduk({
    this.jumlah = 1,
    required this.produk
  });

  void increment() {
    jumlah++;
  }

  void decrement() {
    jumlah--;
  }
}