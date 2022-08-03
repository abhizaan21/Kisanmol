import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BuyerPage extends StatelessWidget {
  const BuyerPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: AppBar(),);}


        AppBar buildAppBar(){
    return AppBar(
          elevation: 0,
          leading: IconButton(icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: (){}
          ),);}}

