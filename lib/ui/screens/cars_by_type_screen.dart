import 'package:flutter/material.dart';

class CarsByTypeScreen extends StatefulWidget {
  const CarsByTypeScreen({super.key});
  static String name = "cars-by-type";
  @override
  State<CarsByTypeScreen> createState() => _CarsByTypeScreenState();
}

class _CarsByTypeScreenState extends State<CarsByTypeScreen> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String carTypeId =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text("Cars by $carTypeId")),
      body: Center(child: Text("Cars by Type")),
    );
  }
}
