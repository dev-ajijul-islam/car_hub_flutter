import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/ui/screens/track_car/order_details_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackCarCard extends StatefulWidget {
  final OrderModel order;

  const TrackCarCard({super.key, required this.order});

  @override
  State<TrackCarCard> createState() => _TrackCarCardState();
}

class _TrackCarCardState extends State<TrackCarCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          OrderDetailsScreen.name,
          arguments: {
            "order": widget.order,
            "car": widget.order.carData,
          },
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.order.carData!["media"]["thumbnail"] == null
                  ? Image.asset(
                AssetsFilePaths.car2,
                fit: BoxFit.fill,
                width: double.maxFinite,
              )
                  : Image.network(
                widget.order.carData!["media"]["thumbnail"],
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: 220,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${widget.order.carData!["title"] ?? 'N/A'}",
                            style: TextTheme.of(context).titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              getPaymentStatusText(widget.order.paymentStatus),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: widget.order.paymentStatus == 'Paid'
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            Text(
                              "\$${widget.order.totalAmount}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${"order_details.delivery".tr()}: ${widget.order.deliveryOption}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "#${widget.order.sId?.substring(0, 6) ?? 'N/A'}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            IconButton(
                              onPressed: () {
                                if (widget.order.sId != null) {
                                  Clipboard.setData(
                                    ClipboardData(text: widget.order.sId!),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "messages.order_id_copied".tr(),
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.copy, size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.order.location,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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

  String getPaymentStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return 'status.paid'.tr();
      case 'pending':
        return 'status.pending'.tr();
      default:
        return status;
    }
  }
}