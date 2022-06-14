// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

part of 'package:acer_store/view.dart';

class HomePage extends StatelessWidget {
  final controller = HomeController();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: panelTransition,
                          top: controller.homeState == HomeState.normal
                              ? headerHeight
                              : -(constraints.maxHeight -
                                  cartBarHeight * 2 -
                                  headerHeight),
                          left: 0,
                          right: 0,
                          height: constraints.maxHeight -
                              headerHeight -
                              cartBarHeight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(defaultPadding * 1.5),
                                bottomRight:
                                    Radius.circular(defaultPadding * 1.5),
                              ),
                            ),
                            child: GridView.builder(
                              itemCount: list_produk.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                mainAxisSpacing: defaultPadding,
                                crossAxisSpacing: defaultPadding,
                              ),
                              itemBuilder: (context, index) => KartuProduk(
                                produk: list_produk[index],
                                press: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: DetailPage(
                                          produk: list_produk[index],
                                          tambahProduk: () {
                                            controller.tambahKeKeranjang(
                                              list_produk[index]);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Card Panel
                        AnimatedPositioned(
                          duration: panelTransition,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: controller.homeState == HomeState.normal
                              ? cartBarHeight
                              : (constraints.maxHeight - cartBarHeight),
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              padding: const EdgeInsets.all(defaultPadding),
                              color: Color(0xFFEAEAEA),
                              alignment: Alignment.topLeft,
                              child: AnimatedSwitcher(
                                duration: panelTransition,
                                child: controller.homeState == HomeState.normal
                                    ? KeranjangRingkasan(controller: controller)
                                    : DetailKeranjang(controller: controller),
                              ),
                            ),
                          ),
                        ),
                        // Header
                        AnimatedPositioned(
                          duration: panelTransition,
                          top: controller.homeState == HomeState.normal
                              ? 0
                              : -headerHeight,
                          right: 0,
                          left: 0,
                          height: headerHeight,
                          child: HomepageHeader(),
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      color: Colors.white,
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang !",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "Alexander Punjab",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black54),
              )
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          )
        ],
      ),
    );
  }
}

class DetailKeranjang extends StatelessWidget {
  final HomeController controller;

  const DetailKeranjang({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Keranjang Belanja", style: Theme.of(context).textTheme.headline6),
          ...List.generate(
            controller.cart.length,
            (index) => KartuDetailKeranjang(productItem: controller.cart[index]),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("BAYAR SEKARANG"),
            ),
          )
        ],
      ),
    );
  }
}

class KartuDetailKeranjang extends StatelessWidget {
  final ItemProduk productItem;

  const KartuDetailKeranjang({Key? key, required this.productItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(productItem.produk!.gambar!),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productItem.produk!.judul!,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Price(amount: productItem.produk!.harga!),
        ],
      ),
      trailing: FittedBox(
        child: Column(
          children: [
            Text(
              "  x ${productItem.jumlah}",
              style: Theme.of(context).textTheme.subtitle1!
            )
          ],
        ),
      ),
    );
  }
}

class KeranjangRingkasan extends StatelessWidget {
  final HomeController controller;

  const KeranjangRingkasan({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Keranjang Belanja",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.cart.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: Hero(
                    tag: controller.cart[index].produk!.judul! + "_cartTag",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage(controller.cart[index].produk!.gambar!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            controller.jumlahItemBelanja().toString(),
            style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
          ),
        )
      ],
    );
  }
}

class KartuProduk extends StatelessWidget {
  final Produk produk;
  final VoidCallback press;

  const KartuProduk({Key? key, required this.produk, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: produk.judul!,
              child: Image.asset(
                produk.gambar!,
              ),
            ),
            Text(
              produk.judul!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                  ),
            ),
            Text(
              "Ultrabook",
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Price(amount: produk.harga!),
                FavBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
