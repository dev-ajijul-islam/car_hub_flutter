import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String name = "home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: SvgPicture.asset(
                    AssetsFilePaths.svgTriangle,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(backgroundColor: Colors.white),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello Michel",
                                  style: TextTheme.of(context).titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        height: 0,
                                      ),
                                ),
                                Text(
                                  "Welcome back!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: ColorScheme.of(context).primary,
                          ),
                          color: Colors.white,
                          onPressed: () {},
                          icon: Icon(Icons.notifications_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 90,
                right: 15,
                child: Image.asset(width: 240, AssetsFilePaths.car2),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined),
                    hintText: "Search",
                    suffixIcon: IconButton(
                      color: ColorScheme.of(context).primary,
                      onPressed: () {},
                      icon: Icon(Icons.read_more_outlined, weight: 800),
                    ),
                  ),
                ),
                CarouselSlider(
                  items: [1, 2, 3, 4, 5].map((s) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(AssetsFilePaths.car2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 30,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          child: Text(
                            "Hot Deal",
                            style: TextTheme.of(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 0.7,
                    autoPlay: true,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
