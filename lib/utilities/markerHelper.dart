import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:partirecept/models/business.dart';
import 'package:latlong2/latlong.dart';

BusinessMarker getBusinessMarkerFromSnapshot(
    AsyncSnapshot snap, Marker marker) {
  // Initialize an empty business marker
  BusinessMarker businessMarker =
      new BusinessMarker("", 0, 0, "", "", "", "", "", "");
  // 1- Loop through the data we have
  snap.data!.docs.forEach((fetchedMarker) => {
        if (LatLng(fetchedMarker.get('business_latitude'),
                fetchedMarker.get('business_longitude')) ==
            marker.point)
          {
            businessMarker.business_latitude =
                fetchedMarker.get('business_latitude'),
            businessMarker.business_longitude =
                fetchedMarker.get('business_longitude'),
            businessMarker.business_name = fetchedMarker.get('business_name'),
            businessMarker.business_postcode =
                fetchedMarker.get('business_postcode'),
            businessMarker.business_streetName =
                fetchedMarker.get('business_street_name'),
            businessMarker.business_streetNumber =
                fetchedMarker.get('business_street_no'),
            businessMarker.business_streetSuffix =
                fetchedMarker.get('business_street_no_add'),
            businessMarker.business_type = fetchedMarker.get('business_type'),
            businessMarker.business_website =
                fetchedMarker.get('business_website'),
          }
      });

  return businessMarker;
}

List<Marker> getMarkersFromSnapshot(AsyncSnapshot snap) {
  return new List<Marker>.from(snap.data!.docs.map(
    (markerPosition) => Marker(
      point: LatLng(markerPosition.get('business_latitude'),
          markerPosition.get('business_longitude')),
      width: 40,
      height: 40,
      builder: (_) => Icon(
        Icons.store,
        size: 40,
        color: Colors.orange,
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
  ));
}
