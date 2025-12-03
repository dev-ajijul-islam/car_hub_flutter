import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void commonDialog(BuildContext context) {

  Future.delayed(Duration(seconds: 1),(){
    Navigator.pop(context);

  });

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(50),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            SvgPicture.asset(AssetsFilePaths.doneSvg),
            Text(
              textAlign: TextAlign.center,
              "Booking request done",
              style: TextTheme.of(context).titleLarge,
            ),
            Text(
              textAlign: TextAlign.center,
              "Your booking request has been sent. Once the admin accepts your request, you will be able to make the payment",
            ),
          ],
        ),
      );
    },
  );
}
