import 'package:flutter/foundation.dart';

class BalanceHistory {
  int id;
  String initialDate;
  String finalDate;
  double finalBalance;

  BalanceHistory({
    @required this.initialDate,
    @required this.finalDate,
    @required this.finalBalance,
  });

  BalanceHistory.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    initialDate = map['initial_date'];
    finalDate = map['final_date'];
    finalBalance = map['final_balance'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'initial_date': initialDate,
      'final_date': finalDate,
      'final_balance': finalBalance,
    };

    return map;
  }
}
