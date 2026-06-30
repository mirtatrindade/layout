import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class PerfilClienteViewModel {

  Future<Map<String, dynamic>?> buscarPerfil(
  int id,
) async {

  final url = Uri.parse(
    "${ApiConfig.baseUrl}/buscar_perfil.php?id=$id",
  );

  final response = await http.get(url);

  final data = jsonDecode(response.body);

  if (data["status"] == "sucesso") {
    return data;
  }

  return null;
}

  Future<bool> atualizarPerfil(
    int id,
    String nome,
    String celular,
    String email,
  ) async {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/editar_perfil.php",
    );

    final response = await http.post(
      url,

      body: {
        "id": id.toString(),
        "nome": nome,
        "celular": celular,
        "email": email,
      },
    );

    final data = jsonDecode(response.body);

    return data["status"] == "sucesso";
  }

  Future<bool> eliminarConta(
    int id,
  ) async {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/eliminar_conta.php",
    );

    final response = await http.post(
      url,

      body: {
        "id": id.toString(),
      },
    );

    final data = jsonDecode(response.body);

    return data["status"] == "sucesso";
  }
}