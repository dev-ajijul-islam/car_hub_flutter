import 'package:car_hub/providers/track_car_provider.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _trackCarDialog(),
        label: Text("Track order"),
        icon: Icon(Icons.gps_fixed),
      ),
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

  void _trackCarDialog() {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Enter tracking code",
          style: TextTheme.of(context).titleMedium,
        ),
        content: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                hintText: "Enter your tracking code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                final trackingCode = codeController.text.trim();
                final codeToUse = codeController.text.trim();

                if (codeToUse != null && codeToUse.isNotEmpty) {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    TrackingProgress.name,
                    arguments: codeToUse,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid tracking code"),
                    ),
                  );
                }
              },
              child: const Text("Track your car"),
            ),
          ],
        ),
      ),
    );
  }
}
