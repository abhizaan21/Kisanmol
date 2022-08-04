import 'package:flutter/material.dart';
import 'package:kisanmol_app/models/fruits_vegs.dart';
import '../models/fruits_and_vegs.dart';
import '../widgets/constants.dart';


class FreshCrops extends StatelessWidget {
  const FreshCrops({Key? key}) : super(key: key);

  Widget _buildDailyFresh(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    FruitsAndVegs fruitsAndVegs = dailyFreshList[index];

    return Padding(
      padding: const EdgeInsets.only(left: appPadding),
      child: SizedBox(
        width: size.width * 0.3,
        child: Column(
          children: [
            Image(
              height: size.height * 0.13,
              fit: BoxFit.fitWidth,
              image: AssetImage(fruitsAndVegs.imageUrl),
            ),
            Text(fruitsAndVegs.name,style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300
            ),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(appPadding),
          child: Text(
            'Fresh Fruits And Vegetable',
            style: TextStyle(
                fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size.height * 0.4,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: freshFruitsList.length,
            itemBuilder: (context, index) {
              return _buildDailyFresh(context, index);
            },
          ),
        ),
      ],
    );
  }
}