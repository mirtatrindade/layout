import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class TelaloginViewModel {
  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o email";
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Email inválido";
    }
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe a senha";
    }
    if (value.length < 4) {
      return "Deve ter no mínimo 4 caracteres";
    }
    return null;
  }

Future<Map<String, dynamic>?> loginAPI(
  String email,
  String senha,
) async {

  try {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/login.php",
    );

    final response = await http.post(
      url,
      body: {
        "email": email,
        "senha": senha,
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      if (data["status"] == "sucesso") {
        return data;
      }
    }

    return null;

  } catch (e) {

    print("Erro login API: $e");
    return null;
  }
}
}