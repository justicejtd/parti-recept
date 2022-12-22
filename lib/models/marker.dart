import 'package:cloud_firestore/cloud_firestore.dart';

class Marker {
  String _id;
  String _name;
  double _latitude;
  double _longitude;
  String _address;
  String _description;
  String _contact;
  String _type;

  Marker(this._id, this._name, this._longitude, this._latitude, this._address,
      this._description, this._contact, this._type);

  convertDocument(QueryDocumentSnapshot markerDocument) {
    this._id = markerDocument.id;
    this._name = markerDocument['name'].toString();
    this._latitude = double.parse(markerDocument.get('latitude').toString());
    this._longitude = double.parse(markerDocument.get('longitude').toString());
    this._description = markerDocument.get('description');
    this._address = markerDocument.get('address').toString();
    this._contact = markerDocument.get('contact').toString();
    this._type = markerDocument.get('type').toString();
  }

  String get id => _id;
  String get name => _name;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get type => _type;
  String get address => _address;
  String get description => _description;
  String get contact => _contact;
}
