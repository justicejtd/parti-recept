// class UserM {
//   String _uid = "";
//   String _name = "";
//   String _age_range = "";
//   String _gender = "";
//   String _residence = "";

//   UserM(this._uid, this._name, this._age_range, this._gender, this._residence);

//   UserM.fromJson(Map<String, dynamic> json) {
//     this._name = json['name'].toString();
//     _age_range = json['age_range'].toString();
//     _gender = json['gender'].toString();
//     _residence = json['residence'].toString();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'uid': _uid,
//       'name': _name,
//       'age_range': _age_range,
//       'gender': _gender,
//       'residence': _residence,
//     };
//   }

//   String get uid => _uid;

//   String get residence => _residence;

//   String get gender => _gender;

//   String get age_range => _age_range;

//   String get name => _name;
// }
