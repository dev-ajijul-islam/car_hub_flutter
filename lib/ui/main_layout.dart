import 'package:car_hub/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  static String name = "main-layout";
   const MainLayout({super.key});


  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  List <Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          currentIndex: currentScreen,
          onTap: (index){
            setState(() {
              currentScreen = index;
            });

          },
          selectedItemColor: ColorScheme.of(context).primary,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_sharp),
              label: "View car",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: "Track car",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
