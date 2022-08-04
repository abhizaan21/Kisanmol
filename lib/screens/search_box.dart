import 'package:flutter/material.dart';
import '../widgets/constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding,
        top: appPadding * 1.5,
      ),
      child: Material(
        elevation: 10.0,
        color: white,
        borderRadius: BorderRadius.circular(21.0),
        child: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.75,
                horizontal: appPadding,
              ),
              fillColor: white,
              hintText: 'Search here....',
              suffixIcon: Icon(
                Icons.search_rounded,
                size: 25,
                color: kBackgroundColor,
              )),
        ),
      ),
    );
  }
}