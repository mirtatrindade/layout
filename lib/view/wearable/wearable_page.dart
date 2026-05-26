import 'package:flutter/material.dart';

class WearablePage extends StatelessWidget {

  final String tempo;
  final String distancia;

  const WearablePage({
    super.key,
    required this.tempo,
    required this.distancia,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      body: Center(

        child: ClipOval(

          child: Container(
            width: 250,
            height: 250,

            color: Colors.black,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Icon(
                  Icons.location_on,
                  color: Colors.cyanAccent,
                  size: 40,
                ),

                const SizedBox(height: 10),

                const Text(
                  "Chegada em",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  tempo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  distancia,
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 18),

                ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(Icons.map),

                  label: const Text(
                    "Ver rota",
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