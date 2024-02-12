import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class SubmitData {
  @JsonKey(name: 'container_number')
  String containerNumber;
  @JsonKey(name: 'iso_size')
  String isoSize;
  @JsonKey(name: 'gross_weight')
  String grossWeight;
  @JsonKey(name: 'tare_weight')
  String tareWeight;
  @JsonKey(name: 'manifacture_date')
  String manifactureDate;
  @JsonKey(name: 'agent_liner')
  String agentLiner;
  @JsonKey(name: 'movement_type')
  String movementType;
  @JsonKey(name: 'vehicle_number')
  String vehicleNumber;
  @JsonKey(name: 'booking_number')
  String bookingNumber;
  @JsonKey(name: 'csc')
  String csc;
  @JsonKey(name: "dynamicFieldsGeneralCleaning")
  DynamicFieldsGeneralCleaning dynamicFieldsGeneralCleaning;
  @JsonKey(name: "dynamicFieldsDamages")
  DynamicFieldsDamages dynamicFieldsDamages;

  SubmitData(
    this.containerNumber,
    this.isoSize,
    this.grossWeight,
    this.tareWeight,
    this.manifactureDate,
    this.agentLiner,
    this.movementType,
    this.vehicleNumber,
    this.bookingNumber,
    this.csc,
    this.dynamicFieldsGeneralCleaning,
    this.dynamicFieldsDamages,
  );

  Map<String, dynamic> toJson() => _$SubmitDataToJson(this);

  factory SubmitData.fromJson(Map<String, dynamic> json) =>
      _$SubmitDataFromJson(json);

  factory SubmitData.fromString(String jsonString) {
    return SubmitData.fromJson(jsonDecode(jsonString));
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class DynamicFieldsGeneralCleaning {
  @JsonKey(name: 'cleaningType')
  List<String> cleaningType;
  @JsonKey(name: 'quantity')
  List<String> quantity;
  @JsonKey(name: 'account')
  List<String> account;
  @JsonKey(name: 'ownercharge')
  List<String> ownerCharge;
  @JsonKey(name: 'third_party_charges')
  List<String> thirdPartyCharges;

  DynamicFieldsGeneralCleaning(this.cleaningType, this.quantity, this.account,
      this.ownerCharge, this.thirdPartyCharges);

  Map<String, dynamic> toJson() => _$DynamicFieldsGeneralCleaningToJson(this);

  factory DynamicFieldsGeneralCleaning.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldsGeneralCleaningFromJson(json);

  factory DynamicFieldsGeneralCleaning.fromString(String jsonString) {
    return DynamicFieldsGeneralCleaning.fromJson(jsonDecode(jsonString));
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class DynamicFieldsDamages {
  @JsonKey(name: 'compcode')
  List<String> compCode;
  @JsonKey(name: 'dmgcode')
  List<String> dmgCode;
  @JsonKey(name: 'repcode')
  List<String> repCode;
  @JsonKey(name: 'location')
  List<String> location;
  @JsonKey(name: 'length')
  List<String> length;
  @JsonKey(name: 'width')
  List<String> width;
  @JsonKey(name: 'damage_quantity')
  List<String> quantity;
  @JsonKey(name: 'acc')
  List<String> account;
  @JsonKey(name: 'manhour')
  List<String> manHour;
  @JsonKey(name: 'metalprice')
  List<String> metalPrice;

  DynamicFieldsDamages(
      this.compCode,
      this.dmgCode,
      this.repCode,
      this.location,
      this.length,
      this.width,
      this.quantity,
      this.account,
      this.manHour,
      this.metalPrice);

  Map<String, dynamic> toJson() => _$DynamicFieldsDamagesToJson(this);

  factory DynamicFieldsDamages.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldsDamagesFromJson(json);

  factory DynamicFieldsDamages.fromString(String jsonString) {
    return DynamicFieldsDamages.fromJson(jsonDecode(jsonString));
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

/*{
"container_number": "ABC123",
"iso_size": "20ft",
"gross_weight": "25000",
"tare_weight": "20000",
"manifacture_date": "2023-01-28",
"agent_liner": "Some liner",
"movement_type": "Import",
"vehicle_number": "XYZ789",
"booking_number": "BK123",
"csc": "CSC123",

"dynamicFieldsGeneralCleaning": {
"cleaningType": ["Type1", "Type2"],
"quantity": ["5", "10"],
"account": ["Account1", "Account2"],
"ownercharge": ["OwnerCharge1", "OwnerCharge2"],
"third_party_charges": ["ThirdParty1", "ThirdParty2"]

},
"dynamicFieldsDamages": {
"compcode": ["CompCode1", "CompCode2"],
"dmgcode": ["DmgCode1", "DmgCode2"],
"repcode": ["RepCode1", "RepCode2"],
"location": ["Location1", "Location2"],
"length": ["10", "15"],
"width": ["5", "7"],
"damage_quantity": ["2", "3"],
"acc": ["Acc1", "Acc2"],
"manhour": ["4", "6"],
"metalprice": ["50", "75"]

}
}*/
