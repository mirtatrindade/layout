import 'package:flutter/material.dart';
import '../viewmodel/evento_viewmodel.dart';

class CrearEventoPage extends StatefulWidget {
  const CrearEventoPage({super.key});

  @override
  State<CrearEventoPage> createState() => _CrearEventoPageState();
}

class _CrearEventoPageState extends State<CrearEventoPage> {
  final viewModel = EventoViewModel();

  final _nome = TextEditingController();
  final _tipo = TextEditingController();
  final _data = TextEditingController();
  final _horas = TextEditingController();
  final _quantidade = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Evento")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nome, decoration: InputDecoration(labelText: "Nome")),
            TextField(controller: _tipo, decoration: InputDecoration(labelText: "Tipo")),
            TextField(controller: _data, decoration: InputDecoration(labelText: "Data (YYYY-MM-DD)")),
            TextField(controller: _horas, decoration: InputDecoration(labelText: "Horas")),
            TextField(controller: _quantidade, decoration: InputDecoration(labelText: "Pessoas")),

            const SizedBox(height: 20),

            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => loading = true);

                      bool ok = await viewModel.crearEvento(
                        1,
                        _nome.text,
                        _tipo.text,
                        _data.text,
                        int.parse(_horas.text),
                        int.parse(_quantidade.text),
                      );

                      setState(() => loading = false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(ok ? "Evento creado" : "Error"),
                        ),
                      );
                    },
                    child: const Text("Guardar"),
                  ),
          ],
        ),
      ),
    );
  }
}