import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../routes/custom_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  String email="", password="", name="";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registeration()async{
    if(password!="" && namecontroller.text!="" && emailcontroller!=""){
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        showSuccessSnackBar(context, "Registered Successfully");
        Navigator.pushReplacementNamed(context, loginScreen);
      }on FirebaseAuthException catch(e) {
        if (e.code == "weak-password") {
          showErrorSnackBar(context, "Password provided is too weak!");
        }else if(e.code == "email-already-in-use"){
          showErrorSnackBar(context, "Account already exists!");
        }else if(e.code == 'invalid-email'){
          showErrorSnackBar(context, "Invalid email format!");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text("Create Account", style: h2),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Create an account so you can explore all the existing jobs",
                      style: h2.copyWith(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 60),
                  CustomTextfield(
                    hint: "Name",
                    controller: namecontroller,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Email",
                    controller: emailcontroller,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Password",
                    controller: passwordcontroller,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomButton(
                      text: "Sign up",
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            name = namecontroller.text;
                            email = emailcontroller.text;
                            password = passwordcontroller.text;
                          });
                        }
                        registeration();
                      },
                      isLarge: true
                  ),
                  SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
              
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                    label: const Text("Continue with Google"),
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                    label: const Text("Continue with Facebook"),
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, loginScreen);
                          },
                          child: const Text(
                              "Sign In",
                              style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}