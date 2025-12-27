class OrderModel {
  final String? sId;
  final String carId;
  final String userId;
  final String deliveryOption;
  final double totalAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final DateTime? createdAt;

  OrderModel({
    this.sId,
    required this.carId,
    required this.userId,
    required this.deliveryOption,
    required this.totalAmount,
    required this.paymentMethod,
    this.paymentStatus = 'Pending',
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      sId: json['_id'],
      carId: json['carId'] ?? '',
      userId: json['userId'] ?? '',
      deliveryOption: json['deliveryOption'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? 'Pending',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'userId': userId,
      'deliveryOption': deliveryOption,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
    };
  }
}
