import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'listar_eventos_page.dart';
import 'fotos_eventos_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Administrador"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 214, 106, 106),

        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const Telalogin(),
                ),
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
                  "Painel Administrativo",
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
                            const ListarEventosPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.list_alt),

                  label: const Text(
                    "Gerenciar eventos",
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
                            const FotosEventosPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.photo_library),

                  label: const Text(
                    "Fotos do salão",
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