class NetworkResponse {
  final int ? statusCode;
  final bool success;
  final String message;
  final Map<String, dynamic>? body;

  NetworkResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    this.body,
  });
}
