class Referral {
  final String name;
  final String id;
  double reward;
  String? investmentStatus;

  Referral({
    required this.name,
    required this.id,
    required this.reward,
    this.investmentStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'reward': reward,
      'investmentStatus': investmentStatus,
    };
  }

  factory Referral.fromMap(Map<String, dynamic> data) {
    return Referral(
      name: data['name'],
      id: data['id'],
      reward: data['reward'],
      investmentStatus: data['investmentStatus'],
    );
  }
}
