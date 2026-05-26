class ApiConfig {
  static const bool usarLocalhost = true;

  static String get baseUrl {
    if (usarLocalhost) {
      return "http://localhost/efesta";
    } else {
      return "http://192.168.1.6/efesta";
    }
  }
}