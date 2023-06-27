class Address {
  final int? zipCode;
  final String? country;
  final String? state;
  final String? stateName;
  final String? city;
  final String? neighborhood;
  final String? address;
  final String? number;
  final String? complement;
  final bool? isOptIn;
  final double? latitude;
  final double? longitude;

  const Address({
    required this.zipCode,
    this.country,
    this.state,
    this.stateName,
    this.city,
    this.neighborhood,
    this.address,
    this.number,
    this.complement,
    this.isOptIn,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'zipCode': zipCode,
      'country': country,
      'state': state,
      'stateName': stateName,
      'city': city,
      'neighborhood': neighborhood,
      'address': address,
      'number': number,
      'complement': complement,
      'isOptIn': isOptIn,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      zipCode: json['zipCode'],
      country: json['country'],
      state: json['state'],
      stateName: json['stateName'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      address: json['address'],
      number: json['number'],
      complement: json['complement'],
      isOptIn: json['isOptIn'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
