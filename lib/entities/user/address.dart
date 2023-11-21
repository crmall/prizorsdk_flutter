class Address {
  /// CEP
  final String? zipCode;

  /// País
  final String? country;

  /// Estado
  final String? state;

  /// Nome do estado
  final String? stateName;

  /// Cidade
  final String? city;

  /// Bairro
  final String? neighborhood;

  /// Endereço
  final String? address;

  /// Número
  final String? number;

  /// Complemento
  final String? complement;

  /// OptIn
  final bool? isOptIn;

  /// Latitude
  final double? latitude;

  /// Longitude
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
