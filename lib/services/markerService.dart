import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as map;
import 'package:partirecept/models/marker.dart';
import 'package:latlong2/latlong.dart';

Marker getMarkerFromSnapshot(AsyncSnapshot snap, map.Marker marker) {
  // Initialize an empty marker
  Marker data_marker = new Marker("", "", 0, 0, "", "", "", "");
  // 1- Loop through the data we have
  snap.data!.docs.forEach((fetchedMarker) => {
        if (LatLng(fetchedMarker.get('latitude'),
                fetchedMarker.get('longitude')) ==
            marker.point)
          {data_marker.convertDocument(fetchedMarker)}
      });
  print(snap);
  return data_marker;
}

List<map.Marker> getMarkersFromSnapshot(AsyncSnapshot snap) {
  return new List<map.Marker>.from(snap.data!.docs.map(
    (markerPosition) => map.Marker(
      point: LatLng(
          markerPosition.get('latitude'), markerPosition.get('longitude')),
      width: 40,
      height: 40,
      builder: (_) => Icon(
        getIconType(markerPosition.get('type')),
        size: 40,
        color: Colors.orange,
      ),
      anchorPos: map.AnchorPos.align(map.AnchorAlign.top),
    ),
  ));
}

IconData getIconType(String type) {
  switch (type) {
    case "Playground":
      return Icons.child_care;

    case "Restaurant":
      return Icons.fastfood;

    case "Entertainment":
      return Icons.extension;

    case "Service":
      return Icons.design_services;

    case "Park":
      return Icons.park;

    case "Resedential":
      return Icons.people;
  }

  return Icons.store;
}
