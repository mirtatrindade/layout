import 'package:flutter/material.dart';

class FotosEventosPage extends StatelessWidget {
  const FotosEventosPage({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> fotos = [
      "assets/decoracao.jpg",
      "assets/comida.jfif",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fotos do Salão"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: fotos.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),

          itemBuilder: (context, index) {

            return ClipRRect(
              borderRadius: BorderRadius.circular(16),

              child: Image.asset(
                fotos[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}