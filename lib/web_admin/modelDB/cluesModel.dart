import 'dart:convert';

class cluesdata {
  final String Type;
  final String Date;
  final String Time;
  final String Location;
  final String Name;
  final String Phone;
  final String Detaill;
  final String Point;

  cluesdata({
    required this.Type,
    required this.Date,
    required this.Time,
    required this.Location,
    required this.Name,
    required this.Phone,
    required this.Detaill,
    required this.Point,
  });

  cluesdata copyWith({
    String? Type,
    String? Date,
    String? Time,
    String? Location,
    String? Name,
    String? Phone,
    String? Detaill,
    String? Point,
  }) {
    return cluesdata(
      Type: Type ?? this.Type,
      Date: Date ?? this.Date,
      Time: Time ?? this.Time,
      Location: Location ?? this.Location,
      Name: Name ?? this.Name,
      Phone: Phone ?? this.Phone,
      Detaill: Detaill ?? this.Detaill,
      Point: Point ?? this.Point,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Type': Type});
    result.addAll({'Date': Date});
    result.addAll({'Time': Time});
    result.addAll({'Location': Location});
    result.addAll({'Name': Name});
    result.addAll({'Phone': Phone});
    result.addAll({'Detail': Detaill});
    result.addAll({'Point': Point});

    return result;
  }

  factory cluesdata.fromMap(Map<String, dynamic> map) {
    return cluesdata(
      Type: map['Type'] ?? '',
      Date: map['Date'] ?? '',
      Time: map['Time'] ?? '',
      Location: map['Location'] ?? '',
      Name: map['Name'] ?? '',
      Phone: map['Phone'] ?? '',
      Detaill: map['Detaill'] ?? '',
      Point: map['Point'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory cluesdata.fromJson(String source) =>
      cluesdata.fromMap(json.decode(source));

  @override
  String toString() {
    return 'cluesdata(Type: $Type, Date: $Date, Time: $Time, Location: $Location, Name: $Name, Phone: $Phone,  Detaill: $Detaill, Point: $Point, )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is cluesdata &&
        other.Type == Type &&
        other.Date == Date &&
        other.Time == Time &&
        other.Location == Location &&
        other.Name == Name &&
        other.Phone == Phone &&
        other.Point == Point &&
        other.Detaill == Detaill;
  }

  @override
  int get hashCode {
    return Type.hashCode ^
        Date.hashCode ^
        Time.hashCode ^
        Location.hashCode ^
        Name.hashCode ^
        Phone.hashCode ^
        Point.hashCode ^
        Detaill.hashCode;
  }
}
