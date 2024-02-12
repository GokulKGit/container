// To parse this JSON data, do
//
//     final apiForGateIn = apiForGateInFromJson(jsonString);

import 'dart:convert';

ApiForGateIn apiForGateInFromJson(String str) =>
    ApiForGateIn.fromJson(json.decode(str));

String apiForGateInToJson(ApiForGateIn data) => json.encode(data.toJson());

class ApiForGateIn {
  String containerNumber;
  String isoSize;
  String grossWeight;
  String tareWeight;
  String manifactureDate;
  String agentLiner;
  String movementType;
  String vehicleNumber;
  String bookingNumber;
  String csc;
  DynamicFieldsGeneralCleaning dynamicFieldsGeneralCleaning;
  Map<String, List<String>> dynamicFieldsDamages;

  ApiForGateIn({
    required this.containerNumber,
    required this.isoSize,
    required this.grossWeight,
    required this.tareWeight,
    required this.manifactureDate,
    required this.agentLiner,
    required this.movementType,
    required this.vehicleNumber,
    required this.bookingNumber,
    required this.csc,
    required this.dynamicFieldsGeneralCleaning,
    required this.dynamicFieldsDamages,
  });

  factory ApiForGateIn.fromJson(Map<String, dynamic> json) => ApiForGateIn(
        containerNumber: json["container_number"],
        isoSize: json["iso_size"],
        grossWeight: json["gross_weight"],
        tareWeight: json["tare_weight"],
        manifactureDate: json["manifacture_date"],
        agentLiner: json["agent_liner"],
        movementType: json["movement_type"],
        vehicleNumber: json["vehicle_number"],
        bookingNumber: json["booking_number"],
        csc: json["csc"],
        dynamicFieldsGeneralCleaning: DynamicFieldsGeneralCleaning.fromJson(
            json["dynamicFieldsGeneralCleaning"]),
        dynamicFieldsDamages: Map.from(json["dynamicFieldsDamages"]).map(
            (k, v) => MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "container_number": containerNumber,
        "iso_size": isoSize,
        "gross_weight": grossWeight,
        "tare_weight": tareWeight,
        "manifacture_date": manifactureDate,
        "agent_liner": agentLiner,
        "movement_type": movementType,
        "vehicle_number": vehicleNumber,
        "booking_number": bookingNumber,
        "csc": csc,
        "dynamicFieldsGeneralCleaning": dynamicFieldsGeneralCleaning.toJson(),
        "dynamicFieldsDamages": Map.from(dynamicFieldsDamages).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
      };
}

class DynamicFieldsGeneralCleaning {
  List<String> cleaningType;
  List<String> quantity;
  List<String> account;
  List<String> ownercharge;
  List<String> thirdPartyCharges;

  DynamicFieldsGeneralCleaning({
    required this.cleaningType,
    required this.quantity,
    required this.account,
    required this.ownercharge,
    required this.thirdPartyCharges,
  });

  factory DynamicFieldsGeneralCleaning.fromJson(Map<String, dynamic> json) =>
      DynamicFieldsGeneralCleaning(
        cleaningType: List<String>.from(json["cleaningType"].map((x) => x)),
        quantity: List<String>.from(json["quantity"].map((x) => x)),
        account: List<String>.from(json["account"].map((x) => x)),
        ownercharge: List<String>.from(json["ownercharge"].map((x) => x)),
        thirdPartyCharges:
            List<String>.from(json["third_party_charges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cleaningType": List<dynamic>.from(cleaningType.map((x) => x)),
        "quantity": List<dynamic>.from(quantity.map((x) => x)),
        "account": List<dynamic>.from(account.map((x) => x)),
        "ownercharge": List<dynamic>.from(ownercharge.map((x) => x)),
        "third_party_charges":
            List<dynamic>.from(thirdPartyCharges.map((x) => x)),
      };
}
