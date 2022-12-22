import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:partirecept/utilities/markerHelper.dart';
import 'package:partirecept/widgets/map/business_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomMap extends StatefulWidget {
  final dynamic markerToBeCentered;
  const CustomMap({Key? key, @required this.markerToBeCentered})
      : super(key: key);
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late StreamController<double> _centerCurrentLocationStreamController;
  LatLng currentCenter = LatLng(51.44958895798621, 5.473718722058829);
  @override
  void initState() {
    super.initState();
    _centerCurrentLocationStreamController = StreamController<double>();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: currentCenter,
              zoom: 16.25,
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('business')
                      .where("__name__", isEqualTo: widget.markerToBeCentered)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return PopupMarkerLayerWidget(
                          options: PopupMarkerLayerOptions(
                              popupController: _popupLayerController,
                              markers: [],
                              markerRotateAlignment: PopupMarkerLayerOptions
                                  .rotationAlignmentFor(AnchorAlign.top),
                              popupBuilder:
                                  (BuildContext context, Marker marker) =>
                                      MapPopup(getBusinessMarkerFromSnapshot(
                                          snapshot, marker))));
                    } else {
                      final marker = getMarkersFromSnapshot(snapshot)[0];
                      this._mapController.move(marker.point, 16.25);
                      this._popupLayerController.togglePopup(marker);
                      return PopupMarkerLayerWidget(
                        options: PopupMarkerLayerOptions(
                            popupController: _popupLayerController,
                            markers: getMarkersFromSnapshot(snapshot),
                            markerRotateAlignment:
                                PopupMarkerLayerOptions.rotationAlignmentFor(
                                    AnchorAlign.top),
                            popupBuilder:
                                (BuildContext context, Marker marker) =>
                                    MapPopup(getBusinessMarkerFromSnapshot(
                                        snapshot, marker))),
                      );
                    }
                  })
            ]));
  }
}
