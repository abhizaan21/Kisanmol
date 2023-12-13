import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kisanmol_app/roles/buyer_screen.dart';
import 'package:kisanmol_app/roles/seller_screen.dart';
import 'package:kisanmol_app/screens/buyer_registration.dart';
import 'package:kisanmol_app/screens/first_view.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import 'package:kisanmol_app/screens/seller_registration.dart';
import 'package:kisanmol_app/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:kisanmol_app/services/user_management.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey:"AIzaSyCOMzL43oC_tJ0y2gHqDQxIaidnqwvFIlU",appId:"1:144720103000:android:1f9362d39564dba423ec2d",messagingSenderId:"144720103000",projectId:"kisanmol-ba099"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'KisanDai',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/splash',
      getPages:[
        GetPage(name: '/splash', page:() => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/sellerRegister', page: () => const SellerRegistrationScreen()),
        GetPage(name: '/buyerRegister', page: () => const BuyerRegistrationScreen()),
        GetPage(name: '/firstView', page: () => const FirstView()),
        GetPage(name: '/buyerScreen', page: () => BuyerPage()),
        GetPage(name: '/sellerScreen', page: () => const SellerPage()),
      ],
      home:   UserManagement().handleAuth(),
    );
  }
}

