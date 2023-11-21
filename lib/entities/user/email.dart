class Email {
  /// Email address of the user.
  final String? email;

  /// OptIn
  final bool? isOptIn;

  const Email({
    required this.email,
    this.isOptIn,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isOptIn': isOptIn,
    };
  }

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      email: json['email'],
      isOptIn: json['isOptIn'],
    );
  }
}
