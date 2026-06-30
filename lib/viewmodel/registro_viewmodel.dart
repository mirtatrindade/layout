import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class RegistroViewModel {

  String? validarNome(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "Digite seu nome completo";
    }

    return null;
  }

  String? validarCelular(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "Digite seu celular";
    }

    return null;
  }

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
    String nome,
    String celular,
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
          "nome": nome,
          "celular": celular,
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