import 'package:car_hub/providers/track_car_provider.dart';
import 'package:car_hub/ui/widgets/track_car_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackCar extends StatefulWidget {
  const TrackCar({super.key});

  @override
  State<TrackCar> createState() => _TrackCarState();
}

class _TrackCarState extends State<TrackCar> {
  @override
  void initState() {
    super.initState();
    // Load orders when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackCarProvider>().getMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Your Car")),
      body: Consumer<TrackCarProvider>(
        builder: (context, trackProvider, child) {
          if (trackProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (trackProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    trackProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => trackProvider.getMyOrders(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (trackProvider.userOrders.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          return ListView.separated(
            itemCount: trackProvider.userOrders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final order = trackProvider.userOrders[index];
              return TrackCarCard(order: order);
            },
            padding: const EdgeInsets.all(20),
          );
        },
      ),
    );
  }
}
