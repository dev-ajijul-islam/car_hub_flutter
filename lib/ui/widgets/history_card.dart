import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 110,
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                AssetsFilePaths.carBg,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    Text(
                      "Audi . RS Q8 . TFSI V8",
                      style: TextTheme.of(
                        context,
                      ).titleMedium?.copyWith(fontSize: 18),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Tracking ID: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "#134509",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Date: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "25 july 2026",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 30),
                        backgroundColor: WidgetStateColor.resolveWith(
                          (states) => Colors.blue.withAlpha(100),
                        ),
                      ),
                      child: Text("In Progress"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
