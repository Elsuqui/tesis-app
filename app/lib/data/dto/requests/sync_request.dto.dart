class SyncRequestDto {
  final String issuedBy;
  final String phoneManufacturer;

  SyncRequestDto({
    required this.issuedBy,
    required this.phoneManufacturer,
  });

  factory SyncRequestDto.fromMap(Map<String, dynamic> json) {
    return SyncRequestDto(
      issuedBy: json['issuedBy'],
      phoneManufacturer: json['phoneManufacturer'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['issuedBy'] = issuedBy;
    data['phoneManufacturer'] = phoneManufacturer;
    return data;
  }
}
