import 'dart:io';

import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  static String name = "personal-information";

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormState>();

  XFile? passportIdImage;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = context.read<AuthProvider>().dbUser;
    if (user != null) {
      _nameController.text = user.name.toString();
      _emailController.text = user.email.toString();
      _phoneController.text = user.phone ?? "";
      _addressController.text = user.address ?? "";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = context.select<AuthProvider, bool>(
          (p) => p.inProgress,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("personal_information.title".tr())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("personal_information.full_name".tr()),
                          _input(
                            controller: _nameController,
                            hint: "personal_information.hint_full_name".tr(),
                            icon: Icons.person_2_outlined,
                            validator: (v) =>
                            v!.isEmpty ? "personal_information.name_required".tr() : null,
                          ),

                          _label("personal_information.email".tr()),
                          _input(
                            controller: _emailController,
                            hint: "personal_information.hint_email".tr(),
                            icon: Icons.email_outlined,
                            enabled: false,
                          ),

                          _label("personal_information.phone_number".tr()),
                          _input(
                            controller: _phoneController,
                            hint: "personal_information.hint_phone".tr(),
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (v) {
                              if (v!.isNotEmpty && v.length < 10) {
                                return "personal_information.valid_phone".tr();
                              }
                              return null;
                            },
                          ),

                          _label("personal_information.address".tr()),
                          _input(
                            controller: _addressController,
                            hint: "personal_information.hint_address".tr(),
                            icon: Icons.location_on_outlined,
                          ),

                          _label("personal_information.upload_passport_id".tr()),
                          _passportPicker(context),

                          const Spacer(),

                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: loading ? null : _onSubmit,
                              child: loading
                                  ? const Loading()
                                  : Text("personal_information.update".tr()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// ---------- SUBMIT ----------
  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final userId = authProvider.firebaseUser?.uid;

    if (userId == null) return;

    await authProvider.updateProfile(
      context: context,
      userId: userId,
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      passportImageFile : passportIdImage,
    );
  }

  /// ---------- UI HELPERS ----------
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _input({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(prefixIcon: Icon(icon), hintText: hint),
    );
  }

  Widget _passportPicker(BuildContext context) {
    return InkWell(
      onTap: _onTapUploadPassport,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) => SizedBox(
            height: 150,
            width: double.infinity,
            child: passportIdImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(passportIdImage!.path),
                fit: BoxFit.cover,
              ),
            )
                : provider.dbUser?.passportIdUrl != null ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                provider.dbUser!.passportIdUrl.toString(),
                fit: BoxFit.cover,
              ),
            ) :  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload_file),
                  Text("personal_information.click_to_upload".tr()),
                ],
              ),
            ),
          ) ,
        ),
      ),
    );
  }

  Future<void> _onTapUploadPassport() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (picked != null) {
      setState(() => passportIdImage = picked);
    }
  }
}