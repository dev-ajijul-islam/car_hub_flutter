import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HotDealCarousel extends StatelessWidget {
  const HotDealCarousel({super.key, required this.hotDealCars});

  final List<CarModel> hotDealCars;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: hotDealCars.map((s) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, CarDetailsScreen.name,arguments: s.sId);
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Card(
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(s.media.thumbnail,),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.black26),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Hot Deal",
                          style: TextTheme.of(
                            context,
                          ).titleLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(viewportFraction: 0.7, autoPlay: true),
    );
  }
}
