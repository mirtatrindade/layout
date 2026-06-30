import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  final _horaInicio = TextEditingController();
  final _duracao = TextEditingController();
  final _adultos = TextEditingController();
  final _criancas = TextEditingController();

  bool loading = false;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  List<DateTime> datasOcupadas = [];

  double total = 0;

  bool incluiComida = false;

  @override
  void initState() {
    super.initState();

    carregarDatasOcupadas();
  }

  Future<void> carregarDatasOcupadas() async {
    datasOcupadas = await viewModel.buscarDatasOcupadas();

    setState(() {});
  }

  bool dataEstaOcupada(DateTime dia) {
    return datasOcupadas.any(
      (data) =>
          data.year == dia.year &&
          data.month == dia.month &&
          data.day == dia.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reserva de Evento")),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              Semantics(
                textField: true,
                label: "Campo nome do evento",

                child: TextField(
                  controller: _nome,

                  decoration: const InputDecoration(
                    labelText: "Nome do evento",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Semantics(
                textField: true,
                label: "Campo tipo do evento",

                child: TextField(
                  controller: _tipo,
                  decoration: const InputDecoration(
                    labelText: "Tipo do evento",
                    hintText: "Ex: aniversário, formatura, chá de fraldas",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Semantics(
                textField: true,
                label: "Campo hora de início",

                child: TextField(
                  controller: _horaInicio,
                  decoration: const InputDecoration(
                    labelText: "Hora de início",
                    hintText: "Ex: 18:00",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Semantics(
                textField: true,
                label: "Campo horas do evento",

                child: TextField(
                  controller: _duracao,
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: "Duração em horas",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Semantics(
                textField: true,
                label: "Campo quantidade de adultos",

                child: TextField(
                  controller: _adultos,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantidade de adultos",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Semantics(
                textField: true,
                label: "Campo quantidade de crianças (2 a 12 anos)",

                child: TextField(
                  controller: _criancas,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantidade de crianças (2 a 12 anos)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 15),

              CheckboxListTile(
                title: const Text("Contratar serviço de alimentação"),

                value: incluiComida,

                onChanged: (value) {
                  setState(() {
                    incluiComida = value ?? false;
                  });
                },
              ),

              Semantics(
                label: "Calendário de seleção de datas",
                child: Center(
                  child: SizedBox(
                    width: 320,

                    child: TableCalendar(
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,

                      enabledDayPredicate: (day) {
                        final hoje = DateTime.now();

                        final dataMinima = DateTime(
                          hoje.year,
                          hoje.month,
                          hoje.day,
                        ).add(const Duration(days: 3));

                        return !day.isBefore(dataMinima);
                      },

                      onDaySelected: (selectedDay, focusedDay) {
                        final hoje = DateTime.now();

                        final dataMinima = DateTime(
                          hoje.year,
                          hoje.month,
                          hoje.day,
                        ).add(const Duration(days: 3));

                        if (selectedDay.isBefore(dataMinima)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "As reservas devem ser feitas com pelo menos 3 dias de antecedência",
                              ),
                            ),
                          );

                          return;
                        }
                        if (dataEstaOcupada(selectedDay)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Esta data já está ocupada"),
                            ),
                          );

                          return;
                        }

                        setState(() {
                          _selectedDay = selectedDay;

                          _focusedDay = focusedDay;

                          _data.text = selectedDay.toString().split(" ")[0];
                        });
                      },

                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          final ocupada = dataEstaOcupada(day);

                          return Container(
                            margin: const EdgeInsets.all(6),

                            decoration: BoxDecoration(
                              color: ocupada ? Colors.red : Colors.green,

                              shape: BoxShape.circle,
                            ),

                            child: Center(
                              child: Text(
                                '${day.day}',

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),

                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Semantics(
                textField: true,
                label: "Campo data do evento",

                child: TextField(
                  controller: _data,
                  readOnly: true,

                  decoration: const InputDecoration(
                    labelText: "Data selecionada",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),

                  label: const Text("Calcular orçamento"),

                  onPressed: () {
                    if (_duracao.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Informe a duração do evento"),
                        ),
                      );

                      return;
                    }

                    final duracao = int.tryParse(_duracao.text);

                    final adultos = int.tryParse(_adultos.text) ?? 0;

                    final criancas = int.tryParse(_criancas.text) ?? 0;

                    if (duracao == null || duracao <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("A duração deve ser maior que zero"),
                        ),
                      );

                      return;
                    }

                    double valor = duracao * 100;

                    if (incluiComida) {
                      valor += adultos * 50;

                      valor += criancas * 25;
                    }

                    setState(() {
                      total = valor;
                    });
                  },
                ),
              ),

              const SizedBox(height: 15),

              if (total > 0)
                Text(
                  "Orçamento aproximado: R\$ ${total.toStringAsFixed(2)}",

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

              const SizedBox(height: 20),

              loading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        // BOTÓN RESERVAR
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.event_available),

                            label: const Text("Reservar"),

                            onPressed: () async {
                              final duracao = int.tryParse(_duracao.text);

                              final adultos = int.tryParse(_adultos.text) ?? 0;

                              final criancas =
                                  int.tryParse(_criancas.text) ?? 0;
                              if (_nome.text.isEmpty ||
                                  _tipo.text.isEmpty ||
                                  _data.text.isEmpty ||
                                  _horaInicio.text.isEmpty ||
                                  duracao == null ||
                                  duracao <= 0 ||
                                  adultos <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Complete todos os campos corretamente",
                                    ),
                                  ),
                                );

                                return;
                              }

                              setState(() => loading = true);

                              if (total <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Calcule o orçamento antes de reservar",
                                    ),
                                  ),
                                );

                                return;
                              }

                              bool ok = await viewModel.crearEvento(
                                1,
                                _nome.text,
                                _tipo.text,
                                _data.text,
                                _horaInicio.text,
                                duracao,
                                adultos,
                                criancas,
                                incluiComida,
                                total,
                              );

                              setState(() => loading = false);

                              if (ok) {
                                await carregarDatasOcupadas();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Evento reservado com sucesso",
                                    ),
                                  ),
                                );

                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Erro ao reservar evento"),
                                  ),
                                );
                              }
                            },

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
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,

                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.close),

                            label: const Text("Cancelar"),

                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
