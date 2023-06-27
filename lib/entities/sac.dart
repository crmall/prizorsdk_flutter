class Sac {
  final String? title;
  final String? content;
  final String? email;
  final String? phone1;
  final String? phone1Caption;
  final String? phone2;
  final String? phone2Caption;

  const Sac({
    required this.title,
    required this.content,
    this.email,
    this.phone1,
    this.phone1Caption,
    this.phone2,
    this.phone2Caption,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'email': email,
      'phone1': phone1,
      'phone1Caption': phone1Caption,
      'phone2': phone2,
      'phone2Caption': phone2Caption,
    };
  }

  factory Sac.fromJson(Map<String, dynamic> json) {
    return Sac(
      title: json['title'],
      content: json['content'],
      email: json['email'],
      phone1: json['phone1'],
      phone1Caption: json['phone1Caption'],
      phone2: json['phone2'],
      phone2Caption: json['phone2Caption'],
    );
  }
}
