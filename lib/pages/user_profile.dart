import 'package:flutter/material.dart';
import 'package:kisanmol_app/widgets/constants.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String urlImage;

  const ProfilePage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: kBackgroundColor,
      title: Text(name),
      centerTitle: true,
    ),
    body: Image.network(
      urlImage,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}