import 'package:flutter/material.dart';
import '../models/fruits_and_vegs.dart';
import '../models/fruits_vegs.dart';
import '../widgets/constants.dart';

class Recommended extends StatelessWidget {
  const Recommended({Key? key}) : super(key: key);

  Widget _Recommended(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    FruitsAndVegs fruitsAndVegs = recommendedList[index];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: appPadding,
            right: appPadding / 2,
            bottom: appPadding,
          ),
          child: Container(
            width: size.width * 0.55,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.2),
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(appPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    height: size.height * 0.23,
                    fit: BoxFit.contain,
                    image: AssetImage(
                      fruitsAndVegs.imageUrl,
                    ),
                  ),
                  Text(
                    fruitsAndVegs.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    fruitsAndVegs.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$ ${fruitsAndVegs.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: appPadding * 2,
          bottom: appPadding / 2,
          child: Container(
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.5),
                    offset: const Offset(3, 3),
                    blurRadius: 3,
                  )
                ]),
            padding: const EdgeInsets.symmetric(
              vertical: appPadding / 4,
              horizontal: appPadding / 1.5,
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.favorite_rounded,
                ),
                Text('Save'),
              ],
            ),
          ),
        )
      ],
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
            'Recommended',
            style: TextStyle(
                fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size.height * 0.4,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: dailyFreshList.length,
            itemBuilder: (context, index) {
              return _Recommended(context, index);
            },
          ),
        )
      ],
    );
  }
}