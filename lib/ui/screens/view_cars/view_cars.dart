import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/view_cars_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCars extends StatefulWidget {
  const ViewCars({super.key});

  @override
  State<ViewCars> createState() => _ViewCarsState();
}

class _ViewCarsState extends State<ViewCars> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<ViewCarsProvider>().getAllCars();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${"view_cars.title".tr()} (${context.watch<ViewCarsProvider>().cars.length})",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ViewCarsProvider>().getAllCars();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              TextField(
                onChanged: (value) {
                  context.read<ViewCarsProvider>().getcarByTitle(title: value);
                },
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    color: ColorScheme.of(context).primary,
                    onPressed: () {
                      _searchController.clear();
                      context.read<ViewCarsProvider>().resetSearch();
                    },
                    icon: const Icon(Icons.close, size: 20),
                  ),
                  hintText: "view_cars.search".tr(),
                ),
              ),
              DropdownMenu(
                onSelected: (String? value) {
                  context.read<ViewCarsProvider>().sortCars(value);
                },
                hintText: "view_cars.sort".tr(),
                enableFilter: true,
                inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                width: 150,
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    label: "view_cars.price_highest_to_lowest".tr(),
                    value: "price-highest-to-lowest",
                  ),
                  DropdownMenuEntry(
                    label: "view_cars.price_lowest_to_highest".tr(),
                    value: "price-lowest-to-highest",
                  ),
                  DropdownMenuEntry(
                    label: "view_cars.year_lowest_to_highest".tr(),
                    value: "year-lowest-to-highest",
                  ),
                  DropdownMenuEntry(
                    label: "view_cars.year_highest_to_lowest".tr(),
                    value: "year-highest-to-lowest",
                  ),
                ],
              ),
              Expanded(
                child: Consumer<ViewCarsProvider>(
                  builder: (context, provider, child) {
                    return provider.errorMessage == null
                        ? provider.cars.isEmpty
                        ? Center(child: Text("view_cars.no_car_found".tr()))
                        : Visibility(
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      visible: provider.isLoading == false,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                        itemCount: provider.cars.length,
                        itemBuilder: (context, index) {
                          CarModel car = provider.cars[index];
                          return CarCard(car: car);
                        },
                      ),
                    )
                        : Center(child: Text(provider.errorMessage.toString()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}