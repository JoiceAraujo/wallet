import 'package:flutter/foundation.dart';

import '../utils/date_converter.dart';

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
    initialDate = DateFormatter().fromDatabase(map['initial_date']);
    finalDate = DateFormatter().fromDatabase(map['final_date']);
    finalBalance = map['final_balance'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'initial_date': DateFormatter().toDatabase(initialDate),
      'final_date': DateFormatter().toDatabase(finalDate),
      'final_balance': finalBalance,
    };

    return map;
  }
}
