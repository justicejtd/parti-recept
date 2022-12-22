
class BusinessMarker {
  String business_name = "";
  double business_latitude = 0.0;
  double business_longitude = 0.0;
  String business_postcode = "";
  String business_streetName = "";
  String business_streetNumber = "";
  String business_streetSuffix = "";
  String business_type = "";
  String business_website = "";

  BusinessMarker(
      this.business_name,
      this.business_longitude,
      this.business_latitude,
      this.business_postcode,
      this.business_streetName,
      this.business_streetNumber,
      this.business_streetSuffix,
      this.business_type,
      this.business_website);

  BusinessMarker.fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      this.business_name = data['business_name'] ?? "";
      this.business_longitude = data['business_longitude'] ?? 0.0;
      this.business_latitude = data['business_latitude'] ?? 0.0;
      this.business_postcode = data['business_postcode'] ?? "";
      this.business_streetName = data['business_street_name'] ?? "";
      this.business_streetNumber = data['business_street_no'] ?? "";
      this.business_type = data['business_type'] ?? "";
      this.business_website = data['business_website'] ?? "";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'business_name': business_name,
      'business_longitude': business_longitude,
      'business_latitude': business_latitude,
      'business_postcode': business_postcode,
      'business_street_name': business_streetName,
      'business_street_no': business_streetNumber,
      'business_type': business_type,
      'business_website': business_website,
    };
  }

  String get name => business_name;
  double get latitude => business_latitude;
  double get longitude => business_longitude;
  String get postcode => business_postcode;
  String get streetName => business_streetName;
  String get streetNumber => business_streetNumber;
  String get streetSuffix => business_streetSuffix;
  String get type => business_type;
  String get website => business_website;
}



