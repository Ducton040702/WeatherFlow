class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radar Map')),
      body: FlutterMap(
        options: MapOptions(
          center: const LatLng(33.7490, -84.3880), // Atlanta is default
          zoom: 8,
        ),
        nonRotatedLayers: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/256/{z}/{x}/{y}@2x?access_token=<YOUR_TOKEN>",
            userAgentPackageName: 'com.weatherflow.app',
          ),
          // TODO: overlay precipitation / wind layers
        ],
      ),
    );
  }
}
