import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  static String name = "personal-information";

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  XFile? passportIdImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text("Full Name"),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: "Full name",
              ),
            ),
            Text("Email"),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: "devajijulislam@gmail.com",
              ),
            ),
            Text("Phone Number"),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: "Enter your phone",
              ),
            ),
            Text("Address"),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: "Enter your address",
              ),
            ),
            Text("Upload Passport / ID"),
            InkWell(
              onTap: _onTapUploadPassport,
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: ColorScheme.of(context).primary),
                ),
                color: Colors.white,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: passportIdImage != null
                      ? Image.file(
                          File(passportIdImage!.path),
                          fit: BoxFit.fill,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_size_select_actual_outlined),
                              Text(
                                "Click to upload",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: FilledButton(onPressed: () {}, child: Text("Update")),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapUploadPassport() async {
    ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        passportIdImage = picked;
      });
    }
  }
}
