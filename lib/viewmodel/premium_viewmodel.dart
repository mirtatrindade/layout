import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class PremiumViewModel {

  Future<bool> comprarPremium(int usuarioId) async {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/comprar_premium.php",
    );

    final response = await http.post(
      url,
      body: {
        "id": usuarioId.toString(),
      },
    );

    final data = jsonDecode(response.body);

    return data["status"] == "sucesso";
  }
}