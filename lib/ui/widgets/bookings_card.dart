import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BookingsCard extends StatefulWidget {
  const BookingsCard({super.key});

  @override
  State<BookingsCard> createState() => _BookingsCardState();
}

class _BookingsCardState extends State<BookingsCard> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CarDetailsScreen.name);
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    AssetsFilePaths.car2,
                    fit: BoxFit.fill,
                    width: double.maxFinite,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Column(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Audi . RS Q8 . TFSI V8",
                          style: TextTheme.of(context).titleMedium,
                        ),
                        const Text("\$22000 "),
                      ],
                    ),
                    Row(
                      spacing: 15,
                      children: [
                        Text("${"bookings_card.year".tr()} : 2025"),
                        Text("${"bookings_card.mileage".tr()} : 1700km")
                      ],
                    ),
                    Row(
                      children: [
                        Text("${"bookings_card.tracking_id".tr()} : "),
                        const Text("#13450")
                      ],
                    ),
                    FilledButton(
                        onPressed: () {},
                        child: Text("bookings_card.pay_now".tr())
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}