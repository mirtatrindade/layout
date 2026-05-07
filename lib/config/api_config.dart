class ApiConfig {
  static const bool usarLocalhost = false;

  static String get baseUrl {
    if (usarLocalhost) {
      return "http://localhost/efesta";
    } else {
      return "http://192.168.1.11/efesta";
    }
  }
}