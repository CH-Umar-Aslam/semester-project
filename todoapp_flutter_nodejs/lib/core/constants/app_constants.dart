class AppConstants {
  static const String API_BASE_URL = 'localhost:3000'; // Use actual domain in production
  static const bool USE_HTTPS = false; // Set to true for production
  static const Map<String, String> HEADERS = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
