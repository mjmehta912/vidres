class GodownDm {
  final String gdName;
  final String gdCode;

  GodownDm({
    required this.gdName,
    required this.gdCode,
  });

  factory GodownDm.fromJson(Map<String, dynamic> json) {
    return GodownDm(
      gdName: json['GDNAME'],
      gdCode: json['GDCODE'],
    );
  }
}
