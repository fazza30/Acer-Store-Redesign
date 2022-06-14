// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

part of 'package:acer_store/view.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key, required this.produk, required this.tambahProduk})
      : super(key: key);

  final Produk produk;
  final VoidCallback tambahProduk;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _cartTag = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding
            ),
            child: ElevatedButton(
              onPressed: () {
                widget.tambahProduk();
                setState(() {
                  _cartTag = '_cartTag';
                });
                Navigator.pop(context);
              },
              child: Text("BELI SEKARANG"),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: Color(0xFFF8F8F8),
                    child: Hero(
                      tag: widget.produk.judul! + _cartTag,
                      child: Image.asset(widget.produk.gambar!),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    child: PenghitungBelanja(),
                  )
                ],
              ),
            ),
            SizedBox(height: defaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  Text(
                    widget.produk.judul!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Price(amount: widget.produk.harga!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                widget.produk.deskripsi!,
                style: TextStyle(
                  color: Color(0xFFBDBDBD),
                  height: 1.8
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Deskripsi",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        FavBtn(radius: 20),
        SizedBox(width: defaultPadding),
      ],
    );
  }
}

class PenghitungBelanja extends StatefulWidget {
  @override
  State<PenghitungBelanja> createState() => _PenghitungBelanjaState();
}

class _PenghitungBelanjaState extends State<PenghitungBelanja> {
  int _counter = 1;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Row(
        children: [
          RoundedButton(
            iconData: Icons.remove,
            color: Color.fromARGB(96, 10, 2, 2),
            press: () {
              if (_counter != 1) {
                _decrementCounter();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 4),
            child: Text(
              "$_counter",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
          RoundedButton(
            iconData: Icons.add,
            press: () {_incrementCounter();},
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.iconData,
    this.color = primaryColor,
    required this.press,
  }) : super(key: key);

  final IconData iconData;
  final Color color;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: CircleBorder(),
      elevation: 0,
      color: Colors.white,
      height: 36,
      minWidth: 36,
      onPressed: press,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }
}