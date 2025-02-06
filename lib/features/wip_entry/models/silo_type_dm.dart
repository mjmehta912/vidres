class SiloTypeDm {
  final String siloTypeName;
  final String siloTypeCode;

  SiloTypeDm({
    required this.siloTypeName,
    required this.siloTypeCode,
  });

  factory SiloTypeDm.fromJson(Map<String, dynamic> json) {
    return SiloTypeDm(
      siloTypeName: json['SiloTypeName'],
      siloTypeCode: json['SiloTypeCode'],
    );
  }
}
