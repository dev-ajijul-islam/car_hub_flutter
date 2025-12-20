import 'package:car_hub/providers/car_by_types_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsByTypeScreen extends StatefulWidget {
  const CarsByTypeScreen({super.key});
  static String name = "cars-by-type";
  @override
  State<CarsByTypeScreen> createState() => _CarsByTypeScreenState();
}

class _CarsByTypeScreenState extends State<CarsByTypeScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        final String carTypeId =
            ModalRoute.of(context)!.settings.arguments as String;
        context.read<CarByTypesProvider>().getcarsByType(carTypeId);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String carTypeId =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cars by $carTypeId (${context.watch<CarByTypesProvider>().cars.length})",
        ),
      ),
      body: Consumer<CarByTypesProvider>(
        builder: (context, provider, child) => ListView.separated(
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) => CarCard(car: provider.cars[index]),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: provider.cars.length,
        ),
      ),
    );
  }
}
