import 'package:flutter/foundation.dart';

class User {
  int id;
  String name;
  double monthlyIncome;
  int balanceHistory;

  User({
    @required this.name,
    @required this.monthlyIncome,
  });

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    monthlyIncome = map['monthly_income'];
    balanceHistory = map['id_balance'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'monthly_income': monthlyIncome,
      'id_balance': balanceHistory,
    };

    return map;
  }
}
