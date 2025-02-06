class SiloDm {
  final String siloCode;
  final String siloName;
  final String? iName;
  final String? iCode;

  SiloDm({
    required this.siloCode,
    required this.siloName,
    this.iName,
    this.iCode,
  });

  factory SiloDm.fromJson(Map<String, dynamic> json) {
    return SiloDm(
      siloCode: json['SiloCode'],
      siloName: json['SiloName'],
      iCode: json['ICODE'] ?? '',
      iName: json['INAME'] ?? '',
    );
  }
}
