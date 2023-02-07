import 'dart:convert';

class cluestype {
  final String laws;

  cluestype({
    required this.laws,
  });

  cluestype copyWith({
    String? laws,
  }) {
    return cluestype(
      laws: laws ?? this.laws,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'laws': laws});

    return result;
  }

  factory cluestype.fromMap(Map<String, dynamic> map) {
    return cluestype(
      laws: map['laws'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory cluestype.fromJson(String source) =>
      cluestype.fromMap(json.decode(source));

  @override
  String toString() {
    return 'cluestype(laws: $laws,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is cluestype && other.laws == laws;
  }

  @override
  int get hashCode {
    return laws.hashCode ^ laws.hashCode;
  }
}
