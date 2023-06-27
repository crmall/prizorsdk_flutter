class Phone {
  final String? phoneNumber;
  final bool? isOptIn;

  const Phone({
    required this.phoneNumber,
    this.isOptIn,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'isOptIn': isOptIn,
    };
  }

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      phoneNumber: json['phoneNumber'],
      isOptIn: json['isOptIn'],
    );
  }
}
