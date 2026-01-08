import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  static String name = "terms-condition";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("terms_condition.title".tr())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "terms_condition_text.content".tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}