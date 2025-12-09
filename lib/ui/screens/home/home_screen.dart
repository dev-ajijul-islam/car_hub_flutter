import 'package:car_hub/ui/screens/home/notifications_screen.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:car_hub/ui/widgets/help_chat_dialog.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:car_hub/ui/widgets/search_dialog/search_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String name = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          openChatDialog(context: context);
        },
        child: Icon(Icons.support_agent_outlined),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
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
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    "https://scontent.fdac24-5.fna.fbcdn.net/v/t39.30808-1/455086251_1029469555479420_7495595057560540792_n.jpg?stp=c0.411.1365.1364a_dst-jpg_s480x480_tt6&_nc_cat=105&ccb=1-7&_nc_sid=1d2534&_nc_eui2=AeHG59vjK7oCVF247ccDGzMkfI0X5DlYQtB8jRfkOVhC0H31wd3jNO6Z2zvdgc1g92xM_OuDQXBb5ScSne_0qs9R&_nc_ohc=_u9iSgq4-TEQ7kNvwFS4qsP&_nc_oc=AdnCpeXKetzlzB4vsJ4yiBDfs0l6F89WlDxilWeY8GwA-xqRhBm-0tR1EoTAIK5GuWw&_nc_zt=24&_nc_ht=scontent.fdac24-5.fna&_nc_gid=bgzSj--_j13pz1yOWe3OjA&oh=00_Afk8fJXUZWEOmLIdsKI86afTO8YhP2EVxVW0XtROLTIiGw&oe=693DD180",
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello, Ajijul Islam",
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
                                foregroundColor: ColorScheme.of(
                                  context,
                                ).primary,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  NotificationsScreen.name,
                                );
                              },
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onTap: _onTapSearchField,
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
                options: CarouselOptions(viewportFraction: 0.7, autoPlay: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Shop by car type",
                  style: TextTheme.of(context).titleMedium,
                ),
              ),
              SizedBox(height: 10),
              CarouselSlider(
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((c) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AssetsFilePaths.carTypeImage1),
                          Text(
                            "Wagon",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  padEnds: false,
                  pageSnapping: false,
                  initialPage: 0,
                  aspectRatio: 4.5,
                  viewportFraction: 0.27,
                  enableInfiniteScroll: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Featured car",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),

                    Column(
                      spacing: 10,
                      children: [CarCard(), CarCard(), CarCard(), CarCard()],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _onTapSearchField() {
    searchDialog(context);
  }
}
