import 'dart:convert';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class EventoViewModel {
  Future<bool> crearEvento(
    int usuarioId,
    String nome,
    String tipo,
    String data,
    int horas,
    int quantidade,
  ) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/crear_evento.php");

    final response = await http.post(url, body: {
      "usuario_id": usuarioId.toString(),
      "nome": nome,
      "tipo": tipo,
      "data": data,
      "horas": horas.toString(),
      "quantidade_pessoas": quantidade.toString(),
    });

    final responseData = jsonDecode(response.body);

    return responseData["status"] == "sucesso";
  }
}