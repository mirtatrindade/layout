import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<bool> loginAPI(String email, String senha) async {
    final url = Uri.parse("http://localhost/efesta/login.php");

    final response = await http.post(
      url,
      body: {"email": email, "senha": senha},
    );

    final data = jsonDecode(response.body);

    if (data["status"] == "sucesso") {
      return true;
    } else {
      return false;
    }
  }
}
