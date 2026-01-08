import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/home/booking_cost_calculation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryInfoScreen extends StatefulWidget {
  const DeliveryInfoScreen({super.key});

  static String name = "delivery-info";

  @override
  State<DeliveryInfoScreen> createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _locationTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CarModel car;
  late String deliveryOption;
  late final user = context.read<AuthProvider>().dbUser;

  @override
  void didChangeDependencies() {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    car = args['car'];
    deliveryOption = args['deliveryOption'];
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _nameTEController.text = user!.name.toString();
    _emailTEController.text = user!.email.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("delivery_info.title".tr())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Scrollable form fields
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "delivery_info.full_name".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: _nameTEController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: "delivery_info.hint_full_name".tr(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'delivery_info.enter_full_name'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "delivery_info.email".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: _emailTEController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outline),
                          hintText: "delivery_info.hint_email".tr(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'delivery_info.enter_email'.tr();
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'delivery_info.enter_valid_email'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "delivery_info.phone_number".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        controller: _phoneTEController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_outlined),
                          hintText: "delivery_info.hint_phone".tr(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'delivery_info.enter_phone'.tr();
                          }
                          if (!RegExp(
                            r'^[0-9]{10,}$',
                          ).hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
                            return 'delivery_info.enter_valid_phone'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "delivery_info.location".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        controller: _locationTEController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: "delivery_info.hint_location".tr(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'delivery_info.enter_location'.tr();
                          }
                          if (value.trim().length < 5) {
                            return 'delivery_info.enter_valid_location'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ), // Extra space at bottom of scroll
                    ],
                  ),
                ),
              ),
            ),

            // Fixed button at bottom
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onTapContinue,
                child: Text("delivery_info.continue".tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapContinue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        BookingCostCalculation.name,
        arguments: {
          'car': car,
          'deliveryOption': deliveryOption,
          'fullName': _nameTEController.text.trim(),
          'email': _emailTEController.text.trim(),
          'phone': _phoneTEController.text.trim(),
          'location': _locationTEController.text.trim(),
        },
      );
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _phoneTEController.dispose();
    _locationTEController.dispose();
    super.dispose();
  }
}