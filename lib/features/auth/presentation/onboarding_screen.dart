import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/custom_router.dart';

class OnboadingScreen extends StatelessWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                SizedBox(height: 80),
                SvgPicture.asset(
                  "assets/images/welcome.svg",
                  height: 300,
                  placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Manage Tasks. Empower Teams.",
                    style: h1,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Your productivity hub, built for you and your team",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    CustomButton(
                      text: "Login",
                      isLarge: false,
                      onPressed: () {
                        Navigator.pushNamed(context, loginScreen);
                      },
                    ),
                    SizedBox(width: 20),
                    CustomButton(
                      text: "Register",
                      isLarge: false,
                      isTransparent: true, // 👈 Transparent with primary text
                      onPressed: () {
                        Navigator.pushNamed(context, registerScreen);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}