import 'package:car_hub/providers/car_types_provider.dart';
import 'package:car_hub/providers/featured_car_provider.dart';
import 'package:car_hub/providers/hot_deal_car_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:car_hub/ui/widgets/car_type_carousel.dart';
import 'package:car_hub/ui/widgets/help_chat_dialog.dart';
import 'package:car_hub/ui/widgets/hero_banner.dart';
import 'package:car_hub/ui/widgets/hot_deal_carousel.dart';
import 'package:car_hub/ui/widgets/search_dialog/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String name = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInitialLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInitialLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final featuredProvider = context.read<FeaturedCarProvider>();
        final hotDealProvider = context.read<HotDealCarProvider>();
        final carTypeProvider = context.read<CarTypesProvider>();
        if (featuredProvider.featuredCars.isEmpty &&
            !featuredProvider.isLoading) {
          featuredProvider.getFeaturedCar();
        }
        if (hotDealProvider.hotDealCars.isEmpty && !hotDealProvider.isLoading) {
          hotDealProvider.getHotDealCar();
        }
        if (carTypeProvider.carTypes.isEmpty && !carTypeProvider.isLoading) {
          carTypeProvider.getCarTypes();
        }
      });
      _isInitialLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final featuredCarProvider = context.watch<FeaturedCarProvider>();
    final hotDealCarsProvider = context.watch<HotDealCarProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          openChatDialog(context: context);
        },
        child: Icon(Icons.support_agent_outlined),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<FeaturedCarProvider>().getFeaturedCar();
        },
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              HeroBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onTap: () {
                    _onTapSearchField(context);
                  },
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
              HotDealCarousel(hotDealCars: hotDealCarsProvider.hotDealCars),
              CarTypeCarousel(),
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

                    if (featuredCarProvider.isLoading &&
                        featuredCarProvider.featuredCars.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      ),

                    if (featuredCarProvider.errorMessage != null &&
                        featuredCarProvider.featuredCars.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Align(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Failed to load featured cars",
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              FilledButton(
                                onPressed: () {
                                  featuredCarProvider.getFeaturedCar();
                                },
                                child: Text("Retry"),
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (!featuredCarProvider.isLoading &&
                        featuredCarProvider.errorMessage == null &&
                        featuredCarProvider.featuredCars.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text("No featured cars available"),
                        ),
                      ),

                    if (featuredCarProvider.featuredCars.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: featuredCarProvider.featuredCars.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final car = featuredCarProvider.featuredCars[index];
                          return CarCard(car: car);
                        },
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

  _onTapSearchField(context) {
    searchDialog(context);
  }
}


