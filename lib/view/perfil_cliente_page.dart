import 'package:flutter/material.dart';
import '../viewmodel/perfil_cliente_viewmodel.dart';
import 'tela_login.dart';


class PerfilClientePage extends StatefulWidget {
  final int usuarioId;

  const PerfilClientePage({super.key, required this.usuarioId});

  @override
  State<PerfilClientePage> createState() => _PerfilClientePageState();
}

class _PerfilClientePageState extends State<PerfilClientePage> {
  final nomeController = TextEditingController();
  final celularController = TextEditingController();
  final emailController = TextEditingController();
  final viewModel = PerfilClienteViewModel();

  @override
  void initState() {
    super.initState();
    carregarPerfil();
  }

  Future<void> carregarPerfil() async {
    final dados = await viewModel.buscarPerfil(widget.usuarioId);

    if (dados != null) {
      nomeController.text = dados["nome"] ?? "";

      celularController.text = dados["celular"] ?? "";

      emailController.text = dados["email"] ?? "";

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meu Perfil")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nomeController,

              decoration: const InputDecoration(labelText: "Nome completo"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: celularController,

              decoration: const InputDecoration(labelText: "Celular"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,

              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(224, 197, 230, 249)),
                onPressed: () async {
                  final ok = await viewModel.atualizarPerfil(
                    widget.usuarioId,
                    nomeController.text,
                    celularController.text,
                    emailController.text,
                  );

                  if (ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Dados atualizados com sucesso"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Erro ao atualizar dados")),
                    );
                  }
                },

                child: const Text("Salvar alterações"),
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),


            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(225, 254, 151, 210)),

                onPressed: () async {
                  final confirmar = await showDialog<bool>(
                    context: context,

                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Excluir conta"),

                        content: const Text(
                          "Tem certeza que quer eliminar a sua conta?",
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },

                            child: const Text("Não"),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },

                            child: const Text("Sim"),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmar == true) {
                    final ok = await viewModel.eliminarConta(widget.usuarioId);

                    if (ok) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Conta eliminada")),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,

                        MaterialPageRoute(builder: (_) => const Telalogin()),

                        (route) => false,
                      );
                    }
                  }
                },

                child: const Text("Eliminar conta"),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
