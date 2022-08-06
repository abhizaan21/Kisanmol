import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisanmol_app/pages/purchase_page.dart';
import 'package:kisanmol_app/pages/user_profile.dart';
import 'package:kisanmol_app/widgets/constants.dart';

import '../models/user_model.dart';
import '../pages/favourite_page.dart';

class MenuDropWidget extends StatefulWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const MenuDropWidget({Key? key}) : super(key: key);

  @override
  _MenuDropWidgetState createState() => _MenuDropWidgetState();
}

class _MenuDropWidgetState extends State<MenuDropWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    const urlImage =
        'https://media-exp1.licdn.com/dms/image/C4E03AQGl1Pydpe2FBA/profile-displayphoto-shrink_800_800/0/1655849039241?e=1665014400&v=beta&t=Go_efWVuUSn0Be1RaN7UysRMcSyGRsE_9R3efPy2VnU';

    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name:("${loggedInUser.firstName} ${loggedInUser.secondName}").toString(),
              email: ("${loggedInUser.email}").toString(),
              onClicked: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                     ProfilePage(
                      name: ("${loggedInUser.firstName} ${loggedInUser.secondName}").toString(),
                      urlImage: urlImage,
                    ),
                  )),
            ),
            Column(
              children: [
                const SizedBox(height: 12),
                buildSearchField(),
                const SizedBox(height: 24),
                buildMenuItem(
                  text: 'Profile',
                  icon: Icons.person_pin,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Favourites',
                  icon: Icons.favorite_border,
                  onClicked: () => selectedItem(context, 1),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Purchases',
                  icon: Icons.shopping_basket,
                  onClicked: () => selectedItem(context, 2),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Updates',
                  icon: Icons.update,
                  onClicked: () => selectedItem(context, 3),
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white70),
                const SizedBox(height: 24),
                buildMenuItem(
                  text: 'Inbox',
                  icon: Icons.messenger_rounded,
                  onClicked: () => selectedItem(context, 4),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Notifications',
                  icon: Icons.notifications_outlined,
                  onClicked: () => selectedItem(context, 5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            const CircleAvatar(
              radius: 24,
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.add_comment_outlined, color: Colors.deepOrangeAccent),
            )
          ],
        ),
      );

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PurchasePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const FavouritePage(),
        ));
        break;
    }
  }