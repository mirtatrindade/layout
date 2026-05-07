import 'package:flutter/material.dart';

import 'mapa_geolocalizacao_page.dart';
import 'crear_evento_page.dart';

class ClientePage extends StatelessWidget {
  const ClientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cliente"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 214, 106, 106),
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

        child: Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),

              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(
                  "Vamos armar a sua festa!",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 214, 106, 106),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const MapaGeolocalizacaoPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.map),

                  label: const Text(
                    "Ver mapa do salão",
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      242,
                      164,
                      164,
                    ),

                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const CrearEventoPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.event),

                  label: const Text(
                    "Reservar evento",
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      183,
                      217,
                      243,
                    ),

                    foregroundColor: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}