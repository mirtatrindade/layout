import 'package:flutter/material.dart';
import 'listar_eventos_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 242, 164, 164),
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
                const Icon(
                  Icons.admin_panel_settings,
                  size: 70,
                  color: Color.fromARGB(255, 242, 164, 164),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Painel Administrativo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 242, 164, 164),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Gerencie os eventos do salão",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ListarEventosPage(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.event),

                    label: const Text("Listar Eventos"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 242, 164, 164),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {

                    },

                    icon: const Icon(Icons.payments),

                    label: const Text("Visualizar Pagamentos"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 183, 217, 243),
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {

                    },

                    icon: const Icon(Icons.photo_library),

                    label: const Text("Fotos dos Eventos"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 248, 191, 172),
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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