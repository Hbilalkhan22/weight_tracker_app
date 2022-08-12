// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeightModel {
  String? userEmail;
  String? weight;
  String? date;
  WeightModel({
    this.userEmail,
    this.weight,
    this.date,
  });

  WeightModel copyWith({
    String? userEmail,
    String? weight,
    String? date,
  }) {
    return WeightModel(
      userEmail: userEmail ?? this.userEmail,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'weight': weight,
      'date': date,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) =>
      WeightModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeightModel(userEmail: $userEmail, weight: $weight, date: $date)';

  @override
  bool operator ==(covariant WeightModel other) {
    if (identical(this, other)) return true;

    return other.userEmail == userEmail &&
        other.weight == weight &&
        other.date == date;
  }

  @override
  int get hashCode => userEmail.hashCode ^ weight.hashCode ^ date.hashCode;
}
