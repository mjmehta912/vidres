class ItemSiloWiseDm {
  final String iName;
  final String iCode;

  ItemSiloWiseDm({
    required this.iName,
    required this.iCode,
  });

  factory ItemSiloWiseDm.fromJson(Map<String, dynamic> json) {
    return ItemSiloWiseDm(
      iName: json['INAME'],
      iCode: json['ICODE'],
    );
  }
}
