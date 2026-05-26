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

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/crear_evento.php",
    );

    final response = await http.post(
      url,

      body: {
        "usuario_id": usuarioId.toString(),
        "nome": nome,
        "tipo": tipo,
        "data": data,
        "horas": horas.toString(),
        "quantidade_pessoas":
            quantidade.toString(),
      },
    );

    final responseData =
        jsonDecode(response.body);

    return responseData["status"] ==
        "sucesso";
  }

  double calcularPresupuesto(
    int horas,
    int pessoas,
  ) {

    return (horas * 100) +
        (pessoas * 10);
  }

  Future<List<DateTime>>
      buscarDatasOcupadas() async {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/listar_datas_ocupadas.php",
    );

    final response =
        await http.get(url);

    final data =
        jsonDecode(response.body);

    return List<DateTime>.from(
      data.map(
        (d) => DateTime.parse(d),
      ),
    );
  }
}