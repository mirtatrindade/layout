import 'dart:convert';

import '../config/api_config.dart';

import 'package:http/http.dart' as http;

class EventoViewModel {
  Future<bool> crearEvento(
    int usuarioId,
    String nome,
    String tipo,
    String data,
    String horaInicio,
    int duracao,
    int adultos,
    int criancas,
    bool comida,
    double orcamento,
  ) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/crear_evento.php");

    final response = await http.post(
      url,

      body: {
        "usuario_id": usuarioId.toString(),
        "nome": nome,
        "tipo": tipo,
        "data": data,
        "hora_inicio": horaInicio,
        "duracao": duracao.toString(),
        "adultos": adultos.toString(),
        "criancas": criancas.toString(),
        "comida": comida ? "1" : "0",
        "orcamento": orcamento.toString(),
      },
    );

    final responseData = jsonDecode(response.body);

    return responseData["status"] == "sucesso";
  }

// Será substituído futuramente pelos valores
// configurados pelo administrador.
  double calcularPresupuesto(int horas, int pessoas) {
    return (horas * 100) + (pessoas * 10);
  }

  Future<List<DateTime>> buscarDatasOcupadas() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/listar_datas_ocupadas.php");

    final response = await http.get(url);

    final data = jsonDecode(response.body);

    return List<DateTime>.from(data.map((d) => DateTime.parse(d)));
  }
}
