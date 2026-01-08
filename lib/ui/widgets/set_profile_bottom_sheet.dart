import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

setProfileBottomSheet(
    BuildContext context, {
      required VoidCallback onTapGallery,
      required VoidCallback onTapCamera,
    }) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "common_dialog.add_photo".tr(),
                  style: TextTheme.of(context).titleSmall,
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    onTapGallery();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.image_outlined),
                      const SizedBox(width: 10),
                      Text("common_dialog.gallery".tr()),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    onTapCamera();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera_alt_outlined),
                      const SizedBox(width: 10),
                      Text("common_dialog.camera".tr()),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: 5,
              child: IconButton(
                color: ColorScheme.of(context).primary.withAlpha(150),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
              ),
            ),
          ],
        ),
      );
    },
  );
}