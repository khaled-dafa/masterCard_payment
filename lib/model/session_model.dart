class SessionModel {
  final int merchantId;
  final int versionId;
  final int correlationId;

  SessionModel({
    required this.merchantId,
    required this.versionId,
    required this.correlationId,
  });
  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
      correlationId: json['correlationId'],
      merchantId: json['merchantId'],
      versionId: json['versionId']);

  Map<String, dynamic> toJson() => {
        'merchantId': merchantId,
        'versionId': versionId,
        'correlationId': correlationId,
      };
}
