import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget{
  final String pathLogo;
  final double sizeLogo;
  final Color backgroundColor;

  const Footer({
    super.key,
    required this.pathLogo,
    this.sizeLogo = 33,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                pathLogo,
                height: sizeLogo,
              )
            ],
          ),
          Divider(
            color: Colors.white,
            height: 45,
            ),
          Row(
            children: [
              SizedBox(width: 50),
              InkWell(
                child: Text('Terms of Service'),
                onTap: () => launchUrl(Uri.parse('https://en.wikipedia.org/wiki/Terms_of_service')),
              ),
              SizedBox(width: 20,),
              InkWell(
                child: Text('Privacy Policy'),
                onTap: () => launchUrl(Uri.parse('https://en.wikipedia.org/wiki/Privacy_policy')),
              ),
              Spacer(),
              InkWell(
                child: Icon(FontAwesomeIcons.github),
                onTap: () => launchUrl(Uri.parse('https://github.com/parabulo/Estagio-SlideW')),
              ),
              SizedBox(width: 20,),
              InkWell(
                child: Icon(FontAwesomeIcons.facebook),
                onTap: () => launchUrl(Uri.parse('https://www.facebook.com/home.php')),
              ),
              SizedBox(width: 20),
              InkWell(
                child: Icon(FontAwesomeIcons.instagram),
                onTap: () => launchUrl(Uri.parse('https://www.instagram.com/')),
              ),
              SizedBox(width: 50)
            ],
          ),
        ],
      ),
    );
  }

}