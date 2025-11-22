import 'package:car_hub/ui/screens/auth/sign_in/reset_email_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/email_verification_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String name = "sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(onPressed: () {}, child: Text("Skip")),
                ),

                Text("Sign Up", style: TextTheme.of(context).titleLarge),
                Text(
                  "Welcome to CarLanda! \n Please enter your details",
                  style: TextTheme.of(context).bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Full name"),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Enter your full name",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Email"),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          hintText: "Enter your Email",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Password"),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: Icon(Icons.visibility_off_outlined),
                          hintText: "Enter your Email",
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                          onPressed: _onTapForgetPasswordButton,
                          child: Text("Forget password"),
                        ),
                      ),
                      FilledButton(onPressed: _onTapSignUpButton, child: Text("Sign up")),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Divider(color: Colors.grey),
                            ),
                          ),
                          Text("Or"),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Divider(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87,
                        ),
                        onPressed: () {},
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AssetsFilePaths.google),
                            Text("Sign in with google"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    text: "Don't have and account ?",
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: ColorScheme.of(context).primary,
                        ),
                        text: "Sign in",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, SignInScreen.name);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapSignUpButton(){
    Navigator.pushNamed(context, EmailVerificationScreen.name);
  }

  _onTapForgetPasswordButton() {
    Navigator.pushNamed(context, ResetEmailScreen.name);
  }
}
