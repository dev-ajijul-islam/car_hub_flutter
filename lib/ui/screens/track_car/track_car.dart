import 'package:car_hub/ui/widgets/track_car_card.dart';
import 'package:flutter/material.dart';

class TrackCar extends StatelessWidget {
  const TrackCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Your Car"),
      ),
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 10,),
        itemBuilder: (context, index) {
          return TrackCarCard();
        },
        padding: EdgeInsets.all(20),

      ),
    );
  }
}
