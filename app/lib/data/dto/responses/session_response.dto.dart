class SessionResponseDto {
  final String uuid;
  final int tableId;
  final String status;
  final String issuedBy;
  final String phoneManufacturer;
  final String expiresAt;

  SessionResponseDto({
    required this.uuid,
    required this.tableId,
    required this.status,
    required this.issuedBy,
    required this.phoneManufacturer,
    required this.expiresAt,
  });

  factory SessionResponseDto.fromJson(Map<String, dynamic> json) {
    return SessionResponseDto(
      uuid: json['uuid'],
      tableId: json['tableId'],
      status: json['status'],
      issuedBy: json['issuedBy'],
      phoneManufacturer: json['phoneManufacturer'],
      expiresAt: json['expiresAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'tableId': tableId,
      'status': status,
      'issuedBy': issuedBy,
      'phoneManufacturer': phoneManufacturer,
      'expiresAt': expiresAt,
    };
  }
}
