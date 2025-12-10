import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  static String name = "change-password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change password")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Existing password", style: TextTheme.of(context).bodyLarge),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Existing password",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_outlined),
              ),
            ),
            Text("New password", style: TextTheme.of(context).bodyLarge),
            TextFormField(
              decoration: InputDecoration(
                hintText: "New password",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_outlined),
              ),
            ),
            Text("Confirm password", style: TextTheme.of(context).bodyLarge),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_outlined),
              ),
            ),
            Spacer(),
            FilledButton(onPressed: (){}, child: Text("Change Password"))
          ],
        ),
      ),
    );
  }
}
