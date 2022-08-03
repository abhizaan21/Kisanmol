import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import 'crops.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        const SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.deepOrangeAccent),
              onPressed: () {},
            ),
            Container(
              height: 50.0,
              width: 288.0,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 15.0),
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.deepOrangeAccent),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(color: Colors.deepOrangeAccent)),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
            // color: Colors.red,
            height: 150,
            child: Stack(
              children: [
                Image.asset('assets/images/homeImage1.png'),
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Crops straight out of farm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Easy to pick your food!',
                        style: TextStyle(
                          color: Color(0xffE2E2E2),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text('All Crops',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.withOpacity(0.6),
            isScrollable: true,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  'Avocado',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Grapes',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Apple',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Grapefruit',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 375.0,
          child: TabBarView(
            controller: tabController,
            children: const <Widget>[
              CropsPage(),
              CropsPage(),
              CropsPage(),
              CropsPage(),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text('Sales',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildFoodItem('assets/images/mango.jpeg', '80', '\$13.88'),
              _buildFoodItem('assets/images/strawberry.jpeg', '75', '\$15.00'),
              _buildFoodItem('assets/images/watermelon.jpeg', '89', '\$11.86')
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildFoodItem(String imgPath, String discount, String price) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 125.0,
            width: 125.0,
          ),
          Positioned(
              left: 15.0,
              child: Container(
                height: 20.0,
                width: 25.0,
                decoration: BoxDecoration(
                    color: const Color(0xFFD2691F),
                    borderRadius: BorderRadius.circular(7.0)
                ),
              )
          ),
          Positioned(
              top: 7.0,
              child: Container(
                  height: 110.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      color: const Color(0xFFAAC2A5),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Image.asset(
                          imgPath,
                          fit: BoxFit.cover,
                          height: 70.0,

                        ),
                        Text(
                            price,
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                        ),
                      ]
                  )
              )
          ),
          Positioned(
              left: 15.0,
              child: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: const BoxDecoration(
                      color: Color(0xFFFE9741),
                      borderRadius:  BorderRadius.only(topLeft: Radius.circular(7.0), bottomRight: Radius.circular(7.0), bottomLeft: Radius.circular(7.0))
                  ),
                  child: Center(
                      child: Text(
                          discount + '%',
                          style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 9.0,
                              color: Colors.white
                          )
                      )
                  )
              )
          ),
        ],
      ),
    );
  }
}
