// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitData _$SubmitDataFromJson(Map<String, dynamic> json) => SubmitData(
      json['container_number'] as String,
      json['iso_size'] as String,
      json['gross_weight'] as String,
      json['tare_weight'] as String,
      json['manifacture_date'] as String,
      json['agent_liner'] as String,
      json['movement_type'] as String,
      json['vehicle_number'] as String,
      json['booking_number'] as String,
      json['csc'] as String,
      DynamicFieldsGeneralCleaning.fromJson(
          json['dynamicFieldsGeneralCleaning'] as Map<String, dynamic>),
      DynamicFieldsDamages.fromJson(
          json['dynamicFieldsDamages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitDataToJson(SubmitData instance) =>
    <String, dynamic>{
      'container_number': instance.containerNumber,
      'iso_size': instance.isoSize,
      'gross_weight': instance.grossWeight,
      'tare_weight': instance.tareWeight,
      'manifacture_date': instance.manifactureDate,
      'agent_liner': instance.agentLiner,
      'movement_type': instance.movementType,
      'vehicle_number': instance.vehicleNumber,
      'booking_number': instance.bookingNumber,
      'csc': instance.csc,
      'dynamicFieldsGeneralCleaning': instance.dynamicFieldsGeneralCleaning,
      'dynamicFieldsDamages': instance.dynamicFieldsDamages,
    };

DynamicFieldsGeneralCleaning _$DynamicFieldsGeneralCleaningFromJson(
        Map<String, dynamic> json) =>
    DynamicFieldsGeneralCleaning(
      (json['cleaningType'] as List<dynamic>).map((e) => e as String).toList(),
      (json['quantity'] as List<dynamic>).map((e) => e as String).toList(),
      (json['account'] as List<dynamic>).map((e) => e as String).toList(),
      (json['ownercharge'] as List<dynamic>).map((e) => e as String).toList(),
      (json['third_party_charges'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DynamicFieldsGeneralCleaningToJson(
        DynamicFieldsGeneralCleaning instance) =>
    <String, dynamic>{
      'cleaningType': instance.cleaningType,
      'quantity': instance.quantity,
      'account': instance.account,
      'ownercharge': instance.ownerCharge,
      'third_party_charges': instance.thirdPartyCharges,
    };

DynamicFieldsDamages _$DynamicFieldsDamagesFromJson(
        Map<String, dynamic> json) =>
    DynamicFieldsDamages(
      (json['compcode'] as List<dynamic>).map((e) => e as String).toList(),
      (json['dmgcode'] as List<dynamic>).map((e) => e as String).toList(),
      (json['repcode'] as List<dynamic>).map((e) => e as String).toList(),
      (json['location'] as List<dynamic>).map((e) => e as String).toList(),
      (json['length'] as List<dynamic>).map((e) => e as String).toList(),
      (json['width'] as List<dynamic>).map((e) => e as String).toList(),
      (json['damage_quantity'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['acc'] as List<dynamic>).map((e) => e as String).toList(),
      (json['manhour'] as List<dynamic>).map((e) => e as String).toList(),
      (json['metalprice'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DynamicFieldsDamagesToJson(
        DynamicFieldsDamages instance) =>
    <String, dynamic>{
      'compcode': instance.compCode,
      'dmgcode': instance.dmgCode,
      'repcode': instance.repCode,
      'location': instance.location,
      'length': instance.length,
      'width': instance.width,
      'damage_quantity': instance.quantity,
      'acc': instance.account,
      'manhour': instance.manHour,
      'metalprice': instance.metalPrice,
    };
