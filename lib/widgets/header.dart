import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  final String pathLogo;
  final double sizeLogo;
  final Color backgroundColor;

  const Header({
    super.key,
    required this.pathLogo,
    this.sizeLogo = 33,
    this.backgroundColor = Colors.white54,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        children: [
          Image.asset(
            pathLogo,
            height: sizeLogo,
          ),
        ],
      ),
    );
  }
}