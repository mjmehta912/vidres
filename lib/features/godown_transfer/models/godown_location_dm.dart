class GodownLocationDm {
  final String gdLocation;
  final int srNo;

  GodownLocationDm({
    required this.gdLocation,
    required this.srNo,
  });

  factory GodownLocationDm.fromJson(Map<String, dynamic> json) {
    return GodownLocationDm(
      gdLocation: json['GDLocation'],
      srNo: json['SrNo'],
    );
  }
}
