import 'dart:convert';

class UserFields {
  static final String rno = 'Rno';
  static final String name = 'Name';
  static final String elc1 = 'ELC1';
  static final String elc2 = 'ELC2';
  static final String elc3 = 'ELC3';
  static final String elc4 = 'ELC4';
  static final String elc5 = 'ELC5';
}

class User {
  final String? Rno;
  final String? Name;
  final String? ELC1;
  final String? ELC2;
  final String? ELC3;
  final String? ELC4;
  final String? ELC5;

  const User({
    /*
    this.Rno,
    required this.Name,
    required this.ELC1,
    required this.ELC2,
    required this.ELC3,
    required this.ELC4,
    */
    this.Rno,
    this.Name,
    this.ELC1,
    this.ELC2,
    this.ELC3,
    this.ELC4,
    this.ELC5,
  });

  Map<String, dynamic> toJson() => {
        UserFields.rno: Rno,
        UserFields.name: Name,
        UserFields.elc1: ELC1,
        UserFields.elc2: ELC2,
        UserFields.elc3: ELC3,
        UserFields.elc4: ELC4,
        UserFields.elc5: ELC5,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        Rno: json['Rno'],
        Name: json['Name'],
        ELC1: json['ELC1'],
        ELC2: json['ELC2'],
        ELC3: json['ELC3'],
        ELC4: json['ELC4'],
        ELC5: json['ELC5'],
      );
}
