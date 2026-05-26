import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class ListarEventosPage extends StatefulWidget {
  const ListarEventosPage({super.key});

  @override
  State<ListarEventosPage> createState() => _ListarEventosPageState();
}

class _ListarEventosPageState extends State<ListarEventosPage> {

  List eventos = [];

  bool loading = true;

  String filtro = "todos";

  @override
  void initState() {
    super.initState();
    carregarEventos();
  }

  Future<void> carregarEventos() async {

    final url = Uri.parse(
      "${ApiConfig.baseUrl}/listar_evento.php",
    );

    final response = await http.get(url);

    final data = jsonDecode(response.body);

    setState(() {
      eventos = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    List eventosFiltrados = eventos;

    if (filtro == "pendente") {

      eventosFiltrados = eventos
          .where((e) => e["estado"] == "pendente")
          .toList();
    }

    if (filtro == "confirmado") {

      eventosFiltrados = eventos
          .where((e) => e["estado"] == "confirmado")
          .toList();
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Eventos"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color.fromARGB(
          255,
          242,
          164,
          164,
        ),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 249, 240, 237),
              Color.fromARGB(255, 248, 191, 172),
              Color.fromARGB(255, 183, 217, 243),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(16),

              child: DropdownButtonFormField(
                value: filtro,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  labelText: "Filtrar eventos",
                ),

                items: const [

                  DropdownMenuItem(
                    value: "todos",
                    child: Text("Todos"),
                  ),

                  DropdownMenuItem(
                    value: "pendente",
                    child: Text("Pendentes"),
                  ),

                  DropdownMenuItem(
                    value: "confirmado",
                    child: Text("Confirmados"),
                  ),
                ],

                onChanged: (value) {

                  setState(() {
                    filtro = value!;
                  });
                },
              ),
            ),

            Expanded(

              child: loading

                  ? const Center(
                      child: CircularProgressIndicator(),
                    )

                  : eventosFiltrados.isEmpty

                      ? const Center(
                          child: Text(
                            "Nenhum evento encontrado",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )

                      : ListView.builder(
                          padding: const EdgeInsets.all(16),

                          itemCount: eventosFiltrados.length,

                          itemBuilder: (context, index) {

                            final evento =
                                eventosFiltrados[index];

                            return Card(
                              margin: const EdgeInsets.only(
                                bottom: 16,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),

                              child: Padding(
                                padding:
                                    const EdgeInsets.all(16),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Text(
                                      evento["nombre"],

                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight:
                                            FontWeight.bold,

                                        color: Color.fromARGB(
                                          255,
                                          242,
                                          164,
                                          164,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Text(
                                      "Tipo: ${evento["tipo"]}",
                                    ),

                                    Text(
                                      "Data: ${evento["fecha"]}",
                                    ),

                                    Text(
                                      "Horas: ${evento["horas"]}",
                                    ),

                                    Text(
                                      "Pessoas: ${evento["cantidad_personas"]}",
                                    ),

                                    Text(
                                      "Estado: ${evento["estado"]}",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}