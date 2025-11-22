import 'package:car_hub/ui/screens/auth/sign_in/reset_password_success.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static String name = "rsest_password";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 10,
                children: [
                  Text(
                    "Reset your password",
                    style: TextTheme.of(context).titleMedium,
                  ),
                  Text("The password must be different than before"),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Password"),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      hintText: "Password",
                    ),
                  ),Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Confirm Password"),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      hintText: "Confirm Password",
                    ),
                  ),
                ],
              ),
              FilledButton(onPressed: _onTapContinue, child: Text("Continue")),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapContinue(){
    Navigator.pushNamed(context, ResetPasswordSuccess.name);
  }
}
