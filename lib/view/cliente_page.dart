import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'mapa_geolocalizacao_page.dart';
import 'crear_evento_page.dart';
import 'perfil_cliente_page.dart';
import 'premium_page.dart';

class ClientePage extends StatelessWidget {
  final int usuarioId;

  const ClientePage({super.key, required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PerfilClientePage(usuarioId: usuarioId),
              ),
            );
          },
        ),

        title: const Text("Cliente"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 214, 106, 106),

        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Telalogin()),
                (route) => false,
              );
            },

            icon: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 214, 106, 106),
            ),

            label: const Text(
              "Sair",
              style: TextStyle(
                color: Color.fromARGB(255, 214, 106, 106),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
                        builder: (_) => const MapaGeolocalizacaoPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.map),

                  label: const Text("Ver mapa do salão"),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 242, 164, 164),

                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => const CrearEventoPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.event),

                  label: const Text("Reservar evento"),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 183, 217, 243),

                    foregroundColor: Colors.black87,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PremiumPage(
    usuarioId: usuarioId,
  ),),
                    );
                  },

                  icon: const Icon(Icons.workspace_premium),

                  label: const Text("Plano Premium"),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Funcionalidades Premium",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text("Reserva prioritária"),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Disponível apenas para usuários Premium",
                        ),
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text("10% de desconto em reservas"),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Disponível apenas para usuários Premium",
                        ),
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text("Cancelamento flexível"),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Disponível apenas para usuários Premium",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
