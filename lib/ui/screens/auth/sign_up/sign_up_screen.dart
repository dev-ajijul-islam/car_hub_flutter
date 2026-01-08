import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_email_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_success_screen.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String name = "sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.select<AuthProvider, bool>(
          (p) => p.inProgress,
    );

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
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _onTapSkipButton,
                    child: Text("skip".tr()),
                  ),
                ),

                Text("sign_up.title".tr(), style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "sign_up.subtitle".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("sign_up.full_name".tr()),
                      ),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) => value == null || value.isEmpty
                            ? "sign_up.enter_name".tr()
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: "sign_up.hint_full_name".tr(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("sign_up.email".tr()),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "sign_up.enter_email".tr();
                          }
                          if (!value.contains("@")) {
                            return "sign_up.enter_valid_email".tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outline_rounded),
                          hintText: "sign_up.hint_email".tr(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("sign_up.password".tr()),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "sign_up.enter_password".tr();
                          }
                          if (value.length < 6) {
                            return "sign_up.password_min_length".tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          hintText: "sign_up.hint_password".tr(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: _onTapForgetPasswordButton,
                          child: Text(
                            "sign_up.forgot_password".tr(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      FilledButton(
                        onPressed: isLoading ? null : _onTapSignUpButton,
                        child: isLoading ? Loading() : Text("sign_up.sign_up_button".tr()),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text("sign_up.or".tr()),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthProvider>().signInWithGoogle(
                            context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AssetsFilePaths.google),
                            const SizedBox(width: 10),
                            Text("sign_up.sign_in_with_google".tr()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey),
                    text: "sign_up.already_have_account".tr(),
                    children: [
                      TextSpan(
                        text: "sign_up.sign_in".tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, SignInScreen.name);
                          },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignUpButton() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await context
        .read<AuthProvider>()
        .signUpWithEmailAndPassword(
      context: context,
      email: _emailController.text.trim(),
      password: _passwordController.text,
      name: _nameController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushNamed(
        context,
        SignUpSuccessScreen.name,
        arguments: {
          "message": "sign_up_success.verification_message".tr(),
        },
      );
    }
  }

  void _onTapSkipButton() {
    Navigator.pushNamedAndRemoveUntil(context, MainLayout.name, (_) => false);
  }

  void _onTapForgetPasswordButton() {
    Navigator.pushNamed(context, ResetEmailScreen.name);
  }
}