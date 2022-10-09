class SessionResponse {
  final String merchant;
  final String result;
  final SessionBody session;

  SessionResponse(
      {required this.session, required this.merchant, required this.result});

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      SessionResponse(
          session: SessionBody.fromJson(json['data']['body']['session']),
          merchant: json['data']['body']['merchant'],
          result: json['data']['body']['result']);
}

class SessionBody {
  final String id;
  final String updateStatus;
  final String version;

  SessionBody(
      {required this.id, required this.updateStatus, required this.version});

  factory SessionBody.fromJson(Map<String, dynamic> json) => SessionBody(
      id: json['id'],
      updateStatus: json['updateStatus'],
      version: json['version']);
}
