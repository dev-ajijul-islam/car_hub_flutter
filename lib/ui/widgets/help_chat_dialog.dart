import 'package:flutter/material.dart';

void openChatDialog({required BuildContext context}) {
  showDialog(
    barrierColor: Colors.transparent,

    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment(0, 0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          height: 400,
          child: Container(
            width: 400,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFF151B27),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
          ),
        ),
      );
    },
  );
}
