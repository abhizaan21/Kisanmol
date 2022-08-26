import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/crop_model.dart';

class CropCard extends StatelessWidget {
  const CropCard({Key? key, required this.cropModel}) : super(key: key);
  final CropModel cropModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("cropDetail${cropModel.type}?"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
