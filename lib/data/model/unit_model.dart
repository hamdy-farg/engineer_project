class UnitModel {
  int? ID;
  String? customer_name;
  String? eng_name;
  String? location_address;
  String? location_description;
  int? UID;
  UnitModel({
    this.ID,
    required this.customer_name,
    required this.eng_name,
    required this.location_address,
    required this.location_description,
    this.UID,
  });
  UnitModel.fromJson(Map<String, dynamic> json) {
    ID = json["id"];
    customer_name = json["customer_name"];
    customer_name = json["eng_name"];
    customer_name = json["location_address"];
    customer_name = json["location_description"];
    UID = json["UID"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["id"] = this.ID;
    data["customer_name"] = this.customer_name;
    data["eng_name"] = this.eng_name;
    data["location_address"] = this.location_address;
    data["location_description"] = this.location_description;
    data["UID"] = this.UID;
    return data;
  }
}
