import 'package:flutter/material.dart';

import '../widgets/constants.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Inbox'),
      centerTitle: true,
      backgroundColor: kBackgroundColor,
    ),
  );
}