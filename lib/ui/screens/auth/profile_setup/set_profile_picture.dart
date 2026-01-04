import 'dart:io';

import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/ui/widgets/set_profile_bottom_sheet.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SetProfilePicture extends StatefulWidget {
  const SetProfilePicture({super.key});
  static String name = "set-profile-picture";

  @override
  State<SetProfilePicture> createState() => _SetProfilePictureState();
}

class _SetProfilePictureState extends State<SetProfilePicture> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) => Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 100),
                        Text(
                          "Add your profile picture",
                          style: TextTheme.of(context).titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Upload a photo so we can recognize you during delivery.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),

                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            _onTapProfileAvatar(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            clipBehavior: Clip.hardEdge,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 80,
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                      width: double.maxFinite,
                                    )
                                  : Image.asset(AssetsFilePaths.profileFrame),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FilledButton(
                      onPressed: provider.inProgress
                          ? null
                          : () async {
                        final success = await provider.updateProfile(
                          context: context,
                          userId: provider.dbUser!.id.toString(),
                          profileImageFile: XFile(_image!.path),
                        );

                        if (success) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            MainLayout.name,
                                (route) => false,
                          );
                        }
                      },
                      child: provider.inProgress
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text("Add Picture"),
                    ),

                  ],
                ),
                Positioned(
                  top: -10,
                  right: 10,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainLayout.name,
                        (route) => false,
                      );
                    },
                    child: Text("Skip"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future takeImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      Navigator.pop(context);
    }
  }

  Future takeImageFromCamera() async {
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      Navigator.pop(context);
    }
  }

  _onTapProfileAvatar(BuildContext context) {
    setProfileBottomSheet(
      context,
      onTapCamera: takeImageFromCamera,
      onTapGallery: takeImageFromGallery,
    );
  }
}
