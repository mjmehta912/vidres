class LoadingPointDm {
  final String lpCode;
  final String lpName;

  LoadingPointDm({
    required this.lpCode,
    required this.lpName,
  });

  factory LoadingPointDm.fromJson(Map<String, dynamic> json) {
    return LoadingPointDm(
      lpCode: json['LPCode'],
      lpName: json['LPName'],
    );
  }
}
