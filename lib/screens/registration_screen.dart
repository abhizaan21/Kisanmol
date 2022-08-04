import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/models/users.dart';
import 'package:kisanmol_app/screens/home_screen.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import 'package:kisanmol_app/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String id = 'registration';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameEditingController =
      TextEditingController();
  final TextEditingController secondNameEditingController =
      TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      TextEditingController();
  bool circular = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    //Start of the creation of the field for different input type

    final firstNameField = TextFormField(
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        //Name validator
        RegExp regex = RegExp(r'^.{3,}$');

        if (value!.isEmpty) {
          return ("This field cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid name min of 3 character");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final secondNameField = TextFormField(
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("This field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final emailField = TextFormField(
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,

      //email validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        //Email validator
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("please enter a valid email[ex: example@gmail.com]");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        iconColor: Colors.teal,
        prefixIcon: const Icon(Icons.mail, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "name@example.com",
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      obscureText: !isPasswordVisible,
      controller: passwordEditingController,
      validator: (value) {
        //Password validator
        RegExp regex = RegExp(r'^.{6,}$');

        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid password min of 6 character");
        }

        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.lock_sharp, color: Colors.deepOrangeAccent),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off, color: Colors.deepOrangeAccent)
              : const Icon(Icons.visibility, color: Colors.black45),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      obscureText: !isPasswordVisible,
      controller: confirmPasswordEditingController,

      //password match validator
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password doesn't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.security, color: Colors.deepOrangeAccent),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off, color: Colors.deepOrangeAccent)
              : const Icon(Icons.visibility, color: Colors.black45),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    //End of the fields creation

    //SignUp Button
    final signUpButton = Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.teal,
        child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            minWidth: MediaQuery.of(context).size.width,
            child: const Text('Register',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: () async {
              setState(() {
                circular = true;
              });
              try {
                firebase_auth.UserCredential userCredential =
                    await firebaseAuth.createUserWithEmailAndPassword(
                        email: emailEditingController.text,
                        password: passwordEditingController.text);
                AuthService(firebase_auth.FirebaseAuth.instance).storeTokenAndData(userCredential);
                Fluttertoast.showToast(msg: "Account created successfully !");
                if (kDebugMode) {
                  print("Error occurred while registering");
                }
                setState(() {
                  circular = false;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) =>  HomePage()),
                    (route) => false);
              } catch (e) {
                final snackbar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                setState(() {
                  circular = false;
                });
              }
            }));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Kisanmol",
            style: GoogleFonts.lateef(
                color: Colors.deepOrangeAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.deepOrangeAccent,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background2.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black12,
                      BlendMode.darken,
                    ))),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 21,
                    ),
                    SizedBox(
                      child: Text("SignUp !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aleo(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    firstNameField,
                    const SizedBox(
                      height: 15,
                    ),
                    secondNameField,
                    const SizedBox(
                      height: 15,
                    ),
                    emailField,
                    const SizedBox(
                      height: 15,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 15,
                    ),
                    confirmPasswordField,
                    const SizedBox(
                      height: 25,
                    ),
                    signUpButton,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.deepOrange,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToServer() async {
    //calling our users.dart for storing the data

    //calling our firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebase_auth.UserCredential as firebase_auth.User?;

    //calling our user model for storing the data
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    //storing the user data to the server
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
  }
}
