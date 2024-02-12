

class ContainerCleaningData {
  String type;
  int quantity;
  String account;
  int ownerCharge;
  int thirdPartyCharges;

  ContainerCleaningData(
      {required this.type,
      required this.quantity,
      required this.account,
      required this.ownerCharge,
      required this.thirdPartyCharges});
}
