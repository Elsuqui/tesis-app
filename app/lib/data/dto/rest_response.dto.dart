class RestResponse {
  final int statusCode;
  final dynamic data;
  final String? errorMessage;

  RestResponse(
    this.statusCode,
    this.data, {
    this.errorMessage,
  });

  factory RestResponse.fromJson(Map<String, dynamic> json) {
    return RestResponse(
      json['statusCode'],
      json['data']['data'],
      errorMessage: json['errorMessage'],
    );
  }

  get isNotValid => statusCode >= 300 && statusCode <= 500;
}
