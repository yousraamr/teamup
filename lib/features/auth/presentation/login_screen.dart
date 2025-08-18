import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/widgets/custom_snackbar.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../constants.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/custom_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen>{

  String email = "", password = "";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> loginUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSuccessSnackBar(context, "Login successful!");
      Navigator.pushReplacementNamed(context, homeScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showErrorSnackBar(context, "Invalid email format");
      } else if (e.code == 'invalid-credential') {
        showErrorSnackBar(context, "Invalid email or password");
      } else if (e.code == 'user-not-found') {
        showErrorSnackBar(context, "No user found with this email");
      } else if (e.code == 'wrong-password') {
        showErrorSnackBar(context, "Incorrect password");
      } else {
        showErrorSnackBar(context, "Login failed: ${e.code}");
      }
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text("Login here", style: h2),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                        "Welcome back you've been missed!",
                        style: h2.copyWith(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 60),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, forgetPasswordScreen);
                      },
                      child: Text(
                        "Forgot your password?",
                        style: body.copyWith(
                          fontSize: 16,
                          color: primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  CustomButton(
                      text: "Sign in",
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = emailcontroller.text.trim();
                            password = passwordcontroller.text.trim();
                          });
                          loginUser(email, password, context);
                        }
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
                        const Text("Don’t have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, registerScreen);

                          },
                          child: const Text(
                              "Sign Up",
                              style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}