import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../viewmodel/mapa_geolocalizacao_viewmodel.dart';

class MapaGeolocalizacaoPage extends StatefulWidget {
  const MapaGeolocalizacaoPage({super.key});

  @override
  State<MapaGeolocalizacaoPage> createState() => _MapaGeolocalizacaoPageState();
}

class _MapaGeolocalizacaoPageState extends State<MapaGeolocalizacaoPage> {
  final MapaGeolocalizacaoViewModel _viewModel = MapaGeolocalizacaoViewModel();

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          // -------------------------------------------------------------------
          // MAPA — FlutterMap com tiles OpenStreetMap
          // -------------------------------------------------------------------
          // O initialCenter e initialZoom definem onde o mapa abre. Quando o
          // usuário obtém a localização, vamos centralizar no ViewModel com
          // _mapController.move(). O TileLayer usa os servidores públicos do
          // OSM; no web funciona sem API key.
          // -------------------------------------------------------------------
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: MapaGeolocalizacaoViewModel.centroInicialPadrao,
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.mobile2_aulas',
              ),
              //quando o ViewModel tiver posicaoAtual preenchida, exibir
              // um marcador no mapa. Use MarkerLayer(markers: [ Marker(point: ...,
              // child: Icon(Icons.location_on), width: 48, height: 48) ]).
              // Só mostre a camada de marcadores se posicao != null.
              MarkerLayer(
                markers: [
                  if (posicao != null)
                    Marker(
                      point: posicao,
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 48,
                      ),
                    ),

                  Marker(
                    point: salon,
                    width: 48,
                    height: 48,
                    child: Icon(Icons.location_on, color: Colors.red, size: 48),
                  ),
                ],
              ),
              // TODO: quando o ViewModel tiver pontosRota não vazio, desenhar a
              // rota no mapa. Use PolylineLayer(polylines: [ Polyline(
              //   points: viewModel.pontosRota, color: Colors.blue, strokeWidth: 4) ]).
              if (pontosRota.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: pontosRota,
                      color: const Color.fromARGB(255, 242, 24, 122),
                      strokeWidth: 4,
                    ),
                  ],
                ),
            ],
          ),

          // -------------------------------------------------------------------
          // Rota até — dois pontos (origem = minha localização; destino = campos)
          // -------------------------------------------------------------------
          Positioned(
            left: 16,
            top: 16,
            right: 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rota até',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Origem: use "Minha localização" antes, ou será o centro padrão.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    
                    if (rotaErro != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          rotaErro,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: const Color.fromARGB(255, 99, 47, 211),
                              ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: rotaLoading
                            ? null
                            : () async {
                                if (posicao == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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

                                await _viewModel.buscarRota(origem, destino);

                                if (_viewModel.pontosRota.isNotEmpty) {
                                  _mapController.move(origem, 13);
                                }
                              },
                        icon: rotaLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.route),
                        label: Text(rotaLoading ? 'Buscando...' : 'Rota até'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -------------------------------------------------------------------
          // Botão flutuante "Minha localização"
          // -------------------------------------------------------------------
          // Ao tocar, chama o ViewModel para obter a posição e depois
          // centralizar o mapa nela (MapController.move).
          // -------------------------------------------------------------------
          Positioned(
            right: 16,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: loading
                      ? null
                      : () async {
                          await _viewModel.obterMinhaLocalizacao();
                          final p = _viewModel.posicaoAtual;
                          if (p != null) _mapController.move(p, 15);
                        },
                  icon: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location),
                  label: Text(loading ? 'Obtendo...' : 'Minha localização'),
                ),
                const SizedBox(height: 12),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (erro != null)
                          Text(
                            erro,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: const Color.fromARGB(
                                    255,
                                    235,
                                    101,
                                    154,
                                  ),
                                ),
                          )
                        else if (posicao != null)
                          Text(
                            'Lat: ${posicao.latitude.toStringAsFixed(5)}\n'
                            'Lng: ${posicao.longitude.toStringAsFixed(5)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        else
                          Text(
                            'Toque em "Minha localização" para obter sua posição.',
                            style: Theme.of(context).textTheme.bodySmall,
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
