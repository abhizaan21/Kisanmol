import 'package:flutter/material.dart';

import '../widgets/constants.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    //drawer: NavigationDrawerWidget(),
    appBar: AppBar(
      title: const Text('Favourite'),
      centerTitle: true,
      backgroundColor: kBackgroundColor,
    ),
  );
}