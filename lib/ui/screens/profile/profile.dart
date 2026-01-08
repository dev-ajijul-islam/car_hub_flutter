import 'dart:io';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/screens/on_start/language_select_screen.dart';
import 'package:car_hub/ui/screens/profile/change_password.dart';
import 'package:car_hub/ui/screens/profile/my_history.dart';
import 'package:car_hub/ui/screens/profile/personal_information.dart';
import 'package:car_hub/ui/screens/profile/terms_and_condition.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            final user = provider.dbUser;

            return Visibility(
              visible: provider.dbUser != null,
              replacement: Center(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.name);
                  },
                  child: Text("profile.login_prompt".tr()),
                ),
              ),
              child: user != null
                  ? ListView(
                children: [
                  const SizedBox(height: 30),
                  Align(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          backgroundImage:
                          profileImage != null && !provider.inProgress
                              ? FileImage(File(profileImage!.path))
                              : user.photo != null
                              ? NetworkImage(user.photo!)
                              : AssetImage(AssetsFilePaths.dummyProfile)
                          as ImageProvider,
                          child:
                          provider.inProgress && profileImage != null
                              ? const CircularProgressIndicator()
                              : null,
                        ),
                        Positioned(
                          bottom: -17,
                          child: GestureDetector(
                            onTap: () => _onTapProfilePicture(provider),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const CircleAvatar(
                                radius: 16,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      Text(
                        user.name.toString(),
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(user.email.toString()),
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      final item = profileTiles[index];
                      return ProfileMenuTile(
                        title: item["title"],
                        icon: item["icon"],
                        switchMode: item["title"] == "profile.notification".tr(),
                        route: item["route"],
                      );
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                    itemCount: profileTiles.length,
                  ),
                ],
              )
                  : const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> profileTiles = [
    {
      "icon": Icons.person_2_outlined,
      "title": "profile.personal_information".tr(),
      "route": PersonalInformation.name,
    },
    {
      "icon": Icons.lock_outline_rounded,
      "title": "profile.change_password".tr(),
      "route": ChangePassword.name,
    },
    {
      "icon": Icons.notifications_outlined,
      "title": "profile.notification".tr()
    },
    {
      "icon": Icons.history_outlined,
      "title": "profile.history".tr(),
      "route": MyHistory.name,
    },
    {
      "icon": Icons.language_outlined,
      "title": "language".tr(),
      "route": LanguageSelectScreen.name,
    },
    {
      "icon": Icons.question_mark,
      "title": "profile.terms_condition".tr(),
      "route": TermsAndCondition.name,
    },
    {
      "icon": Icons.logout_outlined,
      "title": "profile.log_out".tr()
    },
  ];

  Future<void> _onTapProfilePicture(AuthProvider provider) async {
    ImagePicker picker = ImagePicker();
    XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        profileImage = picked;
      });

      // Call updateProfile for profile image only
      final userId = provider.dbUser?.id;
      if (userId != null) {
        await provider.updateProfile(
          context: context,
          userId: userId,
          profileImageFile: picked,
        );
      }
    }
  }
}

class ProfileMenuTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool? switchMode;
  final String? route;

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.icon,
    this.switchMode,
    this.route,
  });

  @override
  State<ProfileMenuTile> createState() => _ProfileMenuTileState();
}

class _ProfileMenuTileState extends State<ProfileMenuTile> {
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.route != null) {
          Navigator.pushNamed(
            context,
            widget.route!,
            arguments: {"fromProfileScreen": true},
          );
        } else if (widget.title == "profile.log_out".tr()) {
          _onTapLogOut();
        }
      },
      leading: Icon(widget.icon),
      trailing: (widget.switchMode == true && widget.switchMode != null)
          ? Switch(
        value: isNotificationOn,
        onChanged: (value) {
          setState(() {
            isNotificationOn = value;
          });
        },
      )
          : const Icon(Icons.chevron_right_outlined),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      tileColor: Colors.white,
      title: Text(widget.title),
    );
  }

  void _onTapLogOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsFilePaths.done),
            Text("profile.log_out_dialog.title".tr(), style: TextTheme.of(context).titleMedium),
            Text(
              textAlign: TextAlign.center,
              "profile.log_out_dialog.message".tr(),
              style: TextTheme.of(context).bodyMedium,
            ),
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("profile.log_out_dialog.no".tr()),
                  ),
                ),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 40),
                    ),
                    onPressed: () {
                      context.read<AuthProvider>().signOut(context);
                    },
                    child: Text("profile.log_out_dialog.yes".tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}