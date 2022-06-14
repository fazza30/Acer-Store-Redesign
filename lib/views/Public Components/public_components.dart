// ignore_for_file: prefer_const_constructors

part of 'package:acer_store/view.dart';

class FavBtn extends StatelessWidget {
  const FavBtn({
    Key? key,
    this.radius = 12,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Color(0xFFE3E2E3),
      child: SvgPicture.asset("assets/icons/heart.svg", color: Colors.green),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    Key? key,
    required this.amount,
  }) : super(key: key);
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Rp. ",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.w600, color: primaryColor, fontSize: 14),
        children: [
          TextSpan(
            text: amount,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}