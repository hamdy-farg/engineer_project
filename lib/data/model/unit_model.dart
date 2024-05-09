class UnitModel {
  int? ID;
  String? customer_name;
  String eng_name;
  String location_address;
  String location_description;
  int UID;
  UnitModel({
    this.ID,
    required this.customer_name,
    required this.eng_name,
    required this.location_address,
    required this.location_description,
    required this.UID,
  });
  factory UnitModel.fromMap(Map<String, dynamic> json) {
    return UnitModel(
        ID: json["ID"],
        customer_name: json["CUSTOMER_NAME"],
        eng_name: json["ENG_NAME"],
        location_address: json["LOCATION_ADDRESS"],
        location_description: json["LOCATION_DESCRIPTION"],
        UID: json["UID"]);
  }
  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "CUSTOMER_NAME": customer_name,
      "ENG_NAME": eng_name,
      "LOCATION_ADDRESS": location_address,
      "LOCATION_DESCRIPTION": location_description,
      "UID": UID
    };
  }
}
