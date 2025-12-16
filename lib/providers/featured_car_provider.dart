import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class FeaturedCarProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<CarModel> featuredCars = [];

  Future<void> getFeaturedCar() async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getFeaturedCar(10),
      );

      if (response.success) {
        featuredCars.clear();

        // Parse the response
        if (response.body?["body"] is List) {
          List<dynamic> list = response.body!["body"];

          // Convert each item to CarModel
          for (var item in list) {
            if (item is Map<String, dynamic>) {
              try {
                featuredCars.add(CarModel.fromJson(item));
              } catch (e) {
                debugPrint("Error parsing car model: $e");
              }
            }
          }

          print("Loaded ${featuredCars.length} featured cars");
        }
      } else {
        errorMessage = "Failed to load featured cars";
      }
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("FeaturedCarProvider error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Optional: Get featured cars with hot deals
  List<CarModel> get hotDealCars {
    return featuredCars.where((car) => car.flags.isHotDeal).toList();
  }

  // Optional: Clear data
  void clearData() {
    featuredCars.clear();
    errorMessage = null;
    notifyListeners();
  }
}