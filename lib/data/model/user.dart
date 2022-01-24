class User {
  final String name;
  final String id;
  final String email;
  final String? referralCode;
  final String? referrarId;

  User({
    required this.name,
    required this.id,
    required this.email,
    required this.referralCode,
    required this.referrarId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'referralCode': referralCode,
      'referrarId': referrarId,
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      id: data['id'],
      email: data['email'],
      referralCode: data['referralCode'],
      referrarId: data['referrarId'],
    );
  }
}
