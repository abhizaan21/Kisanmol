import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
 //form key
  final _formKey= GlobalKey<FormState>();

  final firstNameEditingController= new TextEditingController();
  final secondNameEditingController= new TextEditingController();
  final emailEditingController= new TextEditingController();
  final passwordEditingController= new TextEditingController();
  final confirmPasswordEditingController= new TextEditingController();


  @override
  Widget build(BuildContext context) {
    //Start of the creation of the field for different input type
    
    final firstNameField = TextFormField(
      autofocus: true,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person,color: Colors.orange,),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    final secondNameField = TextFormField(
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person,color: Colors.orange),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    final emailField = TextFormField(
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail,color: Colors.orange),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      controller: passwordEditingController,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_sharp,color: Colors.orange),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      obscureText: true,
      controller: confirmPasswordEditingController,
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.security,color: Colors.orange),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
    );

    //End of the fields creation

    //SignUp Button
    final signUpButton = Material(
      borderRadius: BorderRadius.circular(21),
      color: Colors.lightGreen,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text('SignUp',
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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 44,
              color: Colors.orange,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Text(
                          "Kisanmol",textAlign: TextAlign.center,
                          style:GoogleFonts.calligraffitti(color: Colors.orange,fontSize: 50)
                      ),
                    ),const SizedBox(
                      height: 45,
                    ),
                     SizedBox(
                      child: Text(
                        "SignUp",textAlign: TextAlign.center,
                        style:GoogleFonts.lateef (color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold)
                      ),
                    ),const SizedBox(
                      height: 15,
                    ),
                    firstNameField,
                    const SizedBox(
                      height: 15,
                    ), secondNameField,
                    const SizedBox(
                      height: 15,
                    ), emailField,
                    const SizedBox(
                      height: 15,
                    ), passwordField,
                    const SizedBox(
                      height: 15,
                    ), confirmPasswordField,
                    const SizedBox(
                      height: 15,
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
                              "Login here",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.deepOrange,
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
    );}}
