import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/favorite_provider.dart';
import 'package:car_hub/providers/single_car_provider.dart';
import 'package:car_hub/ui/screens/home/delivery_info_screen.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});
  static String name = "car-details";

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  @override
  void initState() {
    _loadInitialData();
    super.initState();
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final carId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<SingleCarProvider>().getCarById(carId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<SingleCarProvider>(
          builder: (context, provider, _) => Text(provider.car?.title ?? ""),
        ),
      ),
      body: Consumer<SingleCarProvider>(
        builder: (context, provider, child) {
          final car = provider.car;

          if (car == null) {
            return const Center(child: Loading());
          }

          final specs = [
            _spec("car_details.mileage".tr(), "${car.specs.mileageKm} km"),
            _spec("car_details.engine_power".tr(), "${car.specs.enginePowerHp} HP"),
            _spec("car_details.fuel_type".tr(), car.specs.fuelType),
            _spec("car_details.cylinders".tr(), car.specs.cylinders.toString()),
            _spec("car_details.transmission".tr(), car.specs.transmission),
            _spec("car_details.seats".tr(), car.specs.seats.toString()),
            _spec("car_details.interior_color".tr(), car.specs.interiorColor),
            _spec("car_details.exterior_color".tr(), car.specs.exteriorColor),
            _spec("car_details.shipping_cost".tr(), "\$${car.costs.shipping}"),
            _spec("car_details.custom_clearance".tr(), "\$${car.costs.customClearance}"),
          ];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              car.media.thumbnail.isNotEmpty
                                  ? car.media.thumbnail
                                  : 'https://via.placeholder.com/400x250',
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AssetsFilePaths.car2,
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: 200,
                                );
                              },
                            ),
                            Positioned(
                              top: 5,
                              right: 0,
                              child: Consumer<FavoriteProvider>(
                                builder: (context, favProvider, child) {
                                  bool isLoading =
                                      favProvider.isLoading || provider.loading;
                                  return IconButton(
                                    onPressed: isLoading
                                        ? null
                                        : () async {
                                      final isFav =
                                          car.isFavorite ?? false;
                                      final response = isFav
                                          ? await favProvider
                                          .deleteFavorite(
                                        carId: car.sId,
                                      )
                                          : await favProvider
                                          .createFavorite(
                                        carId: car.sId,
                                      );

                                      if (!context.mounted) return;

                                      if (response.success) {
                                        showSnackbarMessage(
                                          context: context,
                                          message: response.message,
                                          color: Colors.green,
                                        );
                                        context
                                            .read<SingleCarProvider>()
                                            .getCarById(car.sId);
                                      } else {
                                        showSnackbarMessage(
                                          context: context,
                                          message: response.message,
                                          color: Colors.red,
                                        );
                                      }
                                    },
                                    icon: isLoading
                                        ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Loading(),
                                    )
                                        : Icon(
                                      car.isFavorite == true
                                          ? Icons.favorite
                                          : Icons
                                          .favorite_border_outlined,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  car.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (car.pricing.discount != null)
                                    Text(
                                      "\$${car.pricing.originalPrice}",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  Text(
                                    "\$${car.pricing.sellingPrice} ${car.pricing.currency}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${"car_details.year".tr()} : ${car.year}"),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${car.location.city}, ${car.location.country}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "car_details.key_specification".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: specs.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.4,
                    ),
                    itemBuilder: (_, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            specs[i]["title"]!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            specs[i]["value"]!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "car_details.details".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(car.description),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => _showDeliveryDialog(context, car),
                      child: Text("car_details.buy_now".tr()),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeliveryDialog(BuildContext context, CarModel car) {
    String? deliveryOption = "Luanda";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("car_details.delivery_options".tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _deliveryRadio(
                    title: "car_details.delivered_to_luanda".tr(),
                    value: "Luanda",
                    groupValue: deliveryOption,
                    onChanged: (val) => setState(() => deliveryOption = val),
                  ),
                  const SizedBox(height: 10),
                  _deliveryRadio(
                    title: "car_details.delivered_to_doorstep".tr(),
                    value: "Doorstep",
                    groupValue: deliveryOption,
                    onChanged: (val) => setState(() => deliveryOption = val),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          DeliveryInfoScreen.name,
                          arguments: {
                            'car': car,
                            'deliveryOption': deliveryOption,
                          },
                        );
                      },
                      child: Text("car_details.continue".tr()),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _deliveryRadio({
    required String title,
    required String value,
    required String? groupValue,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: (v) => onChanged(v.toString()),
          ),
        ],
      ),
    );
  }

  Map<String, String> _spec(String title, String value) => {
    "title": title,
    "value": value,
  };
}