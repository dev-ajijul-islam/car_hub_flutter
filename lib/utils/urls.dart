class Urls {
  static String baseUrl = "http://localhost:3000";
  static String createUser = "$baseUrl/user/create";
  static String loginUser({required String idToken}) =>
      "$baseUrl/user/login?idToken=$idToken";
  static String getFeaturedCar(int limit) =>
      "$baseUrl/cars?limit=$limit&isFeatured=true&isHotDeal=false";
  static String carById(String id) => "$baseUrl/cars/$id";
  static String getHotDealCar = "$baseUrl/cars?isHotDeal=true&limit=10";
}
