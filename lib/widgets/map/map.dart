import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:partirecept/widgets/map/popup.dart';
import 'package:partirecept/services/markerService.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapBody extends StatelessWidget {
  const MapBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MapPage();
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> WoenselMarkers = [];

  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double> _centerCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.never;
    _centerCurrentLocationStreamController = StreamController<double>();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
            options: MapOptions(
              center: LatLng(51.45077326552019, 5.472620185404365),
              zoom: 17.5,
              maxZoom: 18,
              boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(25)),
            ),
            children: [
          TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/mapbox213214123213/ckv71ev5114mm14qmn2wvpbd6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFwYm94MjEzMjE0MTIzMjEzIiwiYSI6ImNrZXk2OXl6djA4ZW8yeG84eDEyamJ1N2wifQ.1RKCVDDvTpz3U0dDrzbXzQ",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoibWFwYm94MjEzMjE0MTIzMjEzIiwiYSI6ImNrZXk2OXl6djA4ZW8yeG84eDEyamJ1N2wifQ.1RKCVDDvTpz3U0dDrzbXzQ',
                'id': 'mapbox.mapbox-traffic-v1'
              },
            ),
          ),
          LocationMarkerLayerWidget(
            options: LocationMarkerLayerOptions(
                markerSize: const Size(20, 20),
                accuracyCircleColor: Colors.green.withOpacity(0.1),
                headingSectorColor: Colors.green.withOpacity(0.8),
                headingSectorRadius: 20,
                markerAnimationDuration: Duration.zero), // disable animation
            plugin: LocationMarkerPlugin(
              centerCurrentLocationStream:
                  _centerCurrentLocationStreamController.stream,
              centerOnLocationUpdate: _centerOnLocationUpdate,
            ),
          ),
          Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  //   Automatically center the location marker on the map when location updated until user interact with the map.
                  setState(() =>
                      _centerOnLocationUpdate = CenterOnLocationUpdate.first);
                  //    Center the location marker on the map and zoom the map to level 18.
                  _centerCurrentLocationStreamController.add(18);
                },
                child: Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
              )),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('marker').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return PopupMarkerLayerWidget(
                      options: PopupMarkerLayerOptions(
                          popupController: _popupLayerController,
                          markers: [],
                          markerRotateAlignment:
                              PopupMarkerLayerOptions.rotationAlignmentFor(
                                  AnchorAlign.top),
                          popupBuilder: (BuildContext context, Marker marker) =>
                              MapPopup(
                                  getMarkerFromSnapshot(snapshot, marker))));
                } else {
                  return PopupMarkerLayerWidget(
                    options: PopupMarkerLayerOptions(
                        popupController: _popupLayerController,
                        markers: getMarkersFromSnapshot(snapshot),
                        markerRotateAlignment:
                            PopupMarkerLayerOptions.rotationAlignmentFor(
                                AnchorAlign.top),
                        popupBuilder: (BuildContext context, Marker marker) =>
                            MapPopup(getMarkerFromSnapshot(snapshot, marker))),
                  );
                }
              })
        ]));
  }
}
