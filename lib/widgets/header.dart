import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  final ImageProvider pathLogo;
  final double sizeLogo;
  final Color backgroundColor;

  const Header({
    super.key,
    required this.pathLogo,
    this.sizeLogo = 33,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      child: Row(
        children: [
          Image(
            image: pathLogo,
            height: sizeLogo,
          ),
        ],
      ),
    );
  }
}