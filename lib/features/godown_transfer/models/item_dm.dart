class ItemDm {
  final String iName;
  final String iCode;

  ItemDm({
    required this.iName,
    required this.iCode,
  });

  factory ItemDm.fromJson(Map<String, dynamic> json) {
    return ItemDm(
      iName: json['INAME'],
      iCode: json['ICODE'],
    );
  }
}
