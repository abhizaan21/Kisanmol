import 'package:flutter/material.dart';
import 'package:kisanmol_app/widgets/constants.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    //drawer: NavigationDrawerWidget(),
    appBar: AppBar(
      title: const Text('Purchases'),
      centerTitle: true,
      backgroundColor:kBackgroundColor,
    ),
  );
}