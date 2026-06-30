import 'package:flutter/material.dart';
import '../viewmodel/premium_viewmodel.dart';

class PremiumPage extends StatefulWidget {
  final int usuarioId;

  const PremiumPage({
    super.key,
    required this.usuarioId,
  });

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  final viewModel = PremiumViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plano Premium"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "PLANO GRATUITO",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text("✓ Reservar eventos"),
            const Text("✓ Ver disponibilidade"),
            const Text("✓ Ver mapa do salão"),

            const Divider(height: 40),

            const Text(
              "PLANO PREMIUM",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "⭐ Reserva prioritária (até 12 meses antes)",
            ),

            const Text(
              "⭐ 10% de desconto em reservas",
            ),

            const Text(
              "⭐ Cancelamento flexível sem multa",
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "R\$ 19,90 / ano",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.workspace_premium),

                label: const Text(
                  "COMPRAR PREMIUM",
                ),

                onPressed: () async {

                  bool ok = await viewModel.comprarPremium(
                    widget.usuarioId,
                  );

                  if (ok) {

                    showDialog(
                      context: context,

                      builder: (_) => AlertDialog(
                        title: const Text("Parabéns!"),

                        content: const Text(
                          "Seu Plano Premium foi ativado com sucesso.",
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },

                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );

                  } else {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Erro ao ativar o Plano Premium",
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}