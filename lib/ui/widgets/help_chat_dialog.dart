import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';

void openChatDialog({required BuildContext context}) {
  showDialog(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Align(
            alignment: Alignment(-0.6, 0.2),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Image.asset(AssetsFilePaths.helpImg),
                              Text(
                                "Help & Support",
                                style: TextTheme.of(context).titleMedium
                                    ?.copyWith(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.do_not_disturb_on_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                children: List.generate(
                                  10,
                                  (index) => ClipPath(
                                    clipper: LowerNipMessageClipper(
                                      (index % 2 == 0)
                                          ? MessageType.send
                                          : MessageType.receive,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      color: (index % 2 == 0)
                                          ? ColorScheme.of(context).primary
                                          : Colors.red.withAlpha(100),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Multiple Points Clipper Bottom Only',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Ask your question",
                                  suffixIcon: IconButton(
                                    color: ColorScheme.of(context).primary,
                                    onPressed: () {},
                                    icon: Icon(Icons.telegram_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
