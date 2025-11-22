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
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add photo", style: TextTheme.of(context).titleSmall),
                SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    onTapGallery();
                  },
                  child: Row(
                    spacing: 10,
                    children: [Icon(Icons.image_outlined), Text("Gallery")],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    onTapCamera();
                  },
                  child: Row(
                    spacing: 10,
                    children: [Icon(Icons.camera_alt_outlined), Text("Camera")],
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
                icon: Icon(Icons.cancel),
              ),
            ),
          ],
        ),
      );
    },
  );
}
