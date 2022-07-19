import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisanmol_app/screens/home_screen.dart';
import 'package:kisanmol_app/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_sharp),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(21),
      color:Colors.lightGreen,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          minWidth: MediaQuery.of(context).size.width,
          child: const Text('Login',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          /*onPressed: () async {
              try {
                final user =
                await firebaseAuth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (user != null) {
                  Navigator.pushNamed(context, "intro_screen");
                }
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
              }
            },*/
          onPressed: () {
            print('pressed');
          },
        ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background1.jpg'),
              fit: BoxFit.cover,colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.darken,
                )
            )),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 221,
                        child: Image.asset('assets/images/Logo.png')),
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
                    loginButton,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            child: const Text(
                              "SignUp!",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  decoration: TextDecoration.underline),
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
}
