import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teamup_app/constants.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  String email = "";
  TextEditingController emailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSuccessSnackBar(context, "Password Reset Email has been sent!");
    }on FirebaseAuthException catch(e) {
      if(e.code == "user-not-found") {
        showErrorSnackBar(context, "No user found for that email.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset(
                  "assets/images/forgot-password.svg",
                  height: 150,
                  placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Don’t worry! It happens. Please enter the email address associated with your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 30),
                CustomTextfield(
                  hint: 'Enter your email address',
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          email = emailcontroller.text;
                        });
                        resetPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Send Reset Link",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
