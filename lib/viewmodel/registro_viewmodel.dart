import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class RegistroViewModel {

  String? validarEmail(String? value) {

    if (value == null || value.isEmpty) {
      return "Digite um email";
    }

    if (!value.contains("@")) {
      return "Email inválido";
    }

    return null;
  }

  String? validarSenha(String? value) {

    if (value == null || value.isEmpty) {
      return "Digite uma senha";
    }

    if (value.length < 4) {
      return "Mínimo 4 caracteres";
    }

    return null;
  }

  Future<bool> registrarUsuario(
    String email,
    String senha,
  ) async {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/registro.php",
    );

    try {

      final response = await http.post(
        url,

        body: {
          "email": email,
          "senha": senha,
        },
      );

      final data = jsonDecode(response.body);

      return data["status"] == "sucesso";

    } catch (e) {

      return false;
    }
  }
}