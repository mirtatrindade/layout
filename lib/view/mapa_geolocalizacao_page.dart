import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../viewmodel/mapa_geolocalizacao_viewmodel.dart';
import 'wearable/wearable_page.dart';

class MapaGeolocalizacaoPage extends StatefulWidget {
  const MapaGeolocalizacaoPage({super.key});

  @override
  State<MapaGeolocalizacaoPage> createState() =>
      _MapaGeolocalizacaoPageState();
}

class _MapaGeolocalizacaoPageState
    extends State<MapaGeolocalizacaoPage> {

  final MapaGeolocalizacaoViewModel _viewModel =
      MapaGeolocalizacaoViewModel();

  final MapController _mapController = MapController();

  final LatLng salon = LatLng(-30.8900, -55.5300);

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _mapController.dispose();
    super.dispose();
  }

  void _onViewModelChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {

    final posicao = _viewModel.posicaoAtual;
    final loading = _viewModel.loading;
    final erro = _viewModel.mensagemErro;
    final pontosRota = _viewModel.pontosRota;
    final rotaLoading = _viewModel.rotaLoading;
    final rotaErro = _viewModel.rotaErro;

    return Scaffold(

      appBar: AppBar(
        title: const Text('Mapas e geolocalização'),
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Stack(
        children: [

          // MAPA
          FlutterMap(
            mapController: _mapController,

            options: MapOptions(
              initialCenter:
                  MapaGeolocalizacaoViewModel
                      .centroInicialPadrao,

              initialZoom: 12,
            ),

            children: [

              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                userAgentPackageName:
                    'com.example.mobile2_aulas',
              ),

              // MARCADORES
              MarkerLayer(
                markers: [

                  if (posicao != null)

                    Marker(
                      point: posicao,
                      width: 48,
                      height: 48,

                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 48,
                      ),
                    ),

                  Marker(
                    point: salon,
                    width: 48,
                    height: 48,

                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                ],
              ),

              // ROTA
              if (pontosRota.isNotEmpty)

                PolylineLayer(
                  polylines: [

                    Polyline(
                      points: pontosRota,

                      color: const Color.fromARGB(
                        255,
                        242,
                        24,
                        122,
                      ),

                      strokeWidth: 4,
                    ),
                  ],
                ),
            ],
          ),

          // CARD ROTA PEQUEÑO
          Positioned(
            left: 12,
            top: 12,

            child: Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),

                child: SizedBox(
                  width: 190,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Row(
                        children: [

                          const Icon(
                            Icons.route,

                            color: Color.fromARGB(
                              255,
                              242,
                              164,
                              164,
                            ),

                            size: 20,
                          ),

                          const SizedBox(width: 6),

                          const Text(
                            'Rota até',

                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Veja a rota até o salão.',

                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),

                      if (rotaErro != null)

                        Padding(
                          padding:
                              const EdgeInsets.only(
                                top: 6,
                              ),

                          child: Text(
                            rotaErro,

                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                            ),
                          ),
                        ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: 130,
                        height: 38,

                        child: ElevatedButton.icon(

                          style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(
                                      255,
                                      242,
                                      164,
                                      164,
                                    ),

                                foregroundColor:
                                    Colors.white,

                                shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                            14,
                                          ),
                                    ),
                              ),

                          onPressed: rotaLoading
                              ? null
                              : () async {

                                  if (posicao == null) {

                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Primero obtené tu ubicación",
                                        ),
                                      ),
                                    );

                                    return;
                                  }

                                  final origem = posicao;
                                  final destino = salon;

                                  await _viewModel
                                      .buscarRota(
                                        origem,
                                        destino,
                                      );

                                  if (_viewModel
                                      .pontosRota
                                      .isNotEmpty) {

                                    _mapController.move(
                                      origem,
                                      13,
                                    );
                                  }
                                },

                          icon: rotaLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,

                                  child:
                                      CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                )
                              : const Icon(
                                  Icons.route,
                                  size: 18,
                                ),

                          label: Text(
                            rotaLoading
                                ? 'Buscando'
                                : 'Ver rota',

                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // BOTONES DERECHA
          Positioned(
            right: 16,
            bottom: 24,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,

              children: [

                // RELOJ
                FloatingActionButton(
                  heroTag: "btnRelogio",

                  backgroundColor:
                      const Color.fromARGB(
                        255,
                        183,
                        217,
                        243,
                      ),

                  onPressed: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => WearablePage(
                          tempo: "12 min",
                          distancia: "4.2 km",
                        ),
                      ),
                    );
                  },

                  child: const Icon(
                    Icons.watch,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                // UBICACIÓN
                FloatingActionButton.extended(
                  heroTag: "btnLocalizacao",

                  backgroundColor:
                      const Color.fromARGB(
                        255,
                        242,
                        164,
                        164,
                      ),

                  foregroundColor: Colors.white,

                  onPressed: loading
                      ? null
                      : () async {

                          await _viewModel
                              .obterMinhaLocalizacao();

                          final p =
                              _viewModel.posicaoAtual;

                          if (p != null) {

                            _mapController.move(
                              p,
                              15,
                            );
                          }
                        },

                  icon: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,

                          child:
                              CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                        )
                      : const Icon(
                          Icons.my_location,
                        ),

                  label: Text(
                    loading
                        ? 'Obtendo...'
                        : 'Minha localização',
                  ),
                ),

                const SizedBox(height: 12),

                // INFO LAT LNG
                Card(
                  margin: EdgeInsets.zero,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Padding(
                    padding:
                        const EdgeInsets.all(12),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        if (erro != null)

                          Text(
                            erro,

                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          )

                        else if (posicao != null)

                          Text(
                            'Lat: ${posicao.latitude.toStringAsFixed(5)}\n'
                            'Lng: ${posicao.longitude.toStringAsFixed(5)}',

                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          )

                        else

                          Text(
                            'Toque em localização.',

                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}