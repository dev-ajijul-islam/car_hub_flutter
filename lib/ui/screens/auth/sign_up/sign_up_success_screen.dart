import 'package:car_hub/ui/screens/auth/profile_setup/set_profile_picture.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});
  static String name = "sign-up-success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset(AssetsFilePaths.svgCurveRectangle, fit: BoxFit.fill),
          Positioned(
            top: 220,
            child: SvgPicture.asset(width: 120, AssetsFilePaths.svgTickLogo),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Positioned(
              top: 500,
              child: Expanded(
                child: Column(
                  spacing: 170,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "Congratulation",
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Text(
                          "You’ve successfully created your account. Let’s get started on your Journey",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    FilledButton(
                      onPressed: () {
                        _onTapGoToSignInScreenButton(context);
                      },
                      child: Text("Continue"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTapGoToSignInScreenButton(BuildContext context) {
    Navigator.pushNamed(context, SetProfilePicture.name);
  }
}
