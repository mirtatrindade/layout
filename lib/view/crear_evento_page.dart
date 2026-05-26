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
  final _horas = TextEditingController();
  final _quantidade = TextEditingController();

  bool loading = false;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  List<DateTime> datasOcupadas = [];

  double total = 0;

  @override
  void initState() {
    super.initState();

    carregarDatasOcupadas();
  }

  Future<void> carregarDatasOcupadas() async {
    datasOcupadas =
        await viewModel.buscarDatasOcupadas();

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
      appBar: AppBar(
        title: const Text("Crear Evento"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              /// NOME
              Semantics(
                textField: true,
                label: "Campo nome do evento",

                child: TextField(
                  controller: _nome,

                  decoration: const InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// TIPO
              Semantics(
                textField: true,
                label: "Campo tipo do evento",

                child: TextField(
                  controller: _tipo,

                  decoration: const InputDecoration(
                    labelText: "Tipo",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// HORAS
              Semantics(
                textField: true,
                label: "Campo horas do evento",

                child: TextField(
                  controller: _horas,
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: "Horas",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// PESSOAS
              Semantics(
                textField: true,
                label: "Campo quantidade de pessoas",

                child: TextField(
                  controller: _quantidade,
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: "Pessoas",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// CALENDÁRIO
              Semantics(
                label: "Calendário de seleção de datas",

                child: TableCalendar(
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,

                  selectedDayPredicate: (day) {
                    return isSameDay(
                      _selectedDay,
                      day,
                    );
                  },

                  onDaySelected: (
                    selectedDay,
                    focusedDay,
                  ) {

                    if (dataEstaOcupada(selectedDay)) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Esta data já está ocupada",
                          ),
                        ),
                      );

                      return;
                    }

                    setState(() {
                      _selectedDay = selectedDay;

                      _focusedDay = focusedDay;

                      _data.text =
                          selectedDay
                              .toString()
                              .split(" ")[0];
                    });
                  },

                  calendarBuilders: CalendarBuilders(

                    defaultBuilder: (
                      context,
                      day,
                      focusedDay,
                    ) {

                      final ocupada =
                          dataEstaOcupada(day);

                      return Container(
                        margin: const EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color: ocupada
                              ? Colors.red
                              : Colors.green,

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

              const SizedBox(height: 20),

              /// DATA ESCOLHIDA
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

              /// TOTAL
              Text(
                "Presupuesto estimado: \$ ${total.toStringAsFixed(2)}",

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              loading
                  ? const CircularProgressIndicator()

                  : SizedBox(
                      width: double.infinity,

                      child: Semantics(
                        button: true,
                        label: "Botão guardar evento",

                        child: ElevatedButton(
                          onPressed: () async {

                            final horas =
                                int.tryParse(_horas.text);

                            final pessoas =
                                int.tryParse(_quantidade.text);

                            if (horas == null ||
                                pessoas == null) {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Digite números válidos",
                                  ),
                                ),
                              );

                              return;
                            }

                            if (_data.text.isEmpty) {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Selecione uma data",
                                  ),
                                ),
                              );

                              return;
                            }

                            setState(() {

                              total =
                                  viewModel.calcularPresupuesto(
                                horas,
                                pessoas,
                              );
                            });

                            setState(() => loading = true);

                            bool ok =
                                await viewModel.crearEvento(
                              1,
                              _nome.text,
                              _tipo.text,
                              _data.text,
                              horas,
                              pessoas,
                            );

                            setState(() => loading = false);

                            if (ok) {

                              await carregarDatasOcupadas();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Evento creado",
                                  ),
                                ),
                              );

                            } else {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Error ao criar evento",
                                  ),
                                ),
                              );
                            }
                          },

                          child: const Text("Guardar"),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}