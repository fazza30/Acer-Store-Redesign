part of 'controller.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

  List<ItemProduk> cart = [];

  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  void tambahKeKeranjang(Produk produk) {
    for (ItemProduk item in cart) {
      if (item.produk!.judul == produk.judul) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(ItemProduk(produk: produk));
    notifyListeners();
  }

  int jumlahItemBelanja() => cart.fold(
    0,
    ((previousValue, element) => previousValue + element.jumlah)
  );
}