import 'package:car_hub/ui/screens/auth/sign_in/reset_password_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static String name = "verify-email";

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Verify your email address ",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),
                    Text("We have sent a code to your "),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "micheljhon@gmail.com ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorScheme.of(context).primary,
                        ),
                        children: [
                          TextSpan(
                            text: "Enter it below to activate your account ",
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PinCodeTextField(
                        backgroundColor: Colors.transparent,
                        keyboardType: TextInputType.number,
                        showCursor: false,
                        pinTheme: PinTheme(shape: PinCodeFieldShape.circle),
                        appContext: context,
                        length: 6,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FilledButton(
                      onPressed: _onTapVerifyButton,
                      child: Text("Verify"),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Did'nt recive a code ? ",
                        style: TextTheme.of(context).bodyMedium,
                        children: [
                          TextSpan(
                            text: "Resend Code",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorScheme.of(context).primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapVerifyButton() {
    Navigator.pushNamed(context, SignUpSuccessScreen.name);
  }
}
