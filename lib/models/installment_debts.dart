import 'package:flutter/foundation.dart';

import '../utils/date_formatter.dart';

class InstallmentDebts {
  int id;
  double installmentValue;
  String dateExpiration;
  int debtId;

  InstallmentDebts({
    @required this.installmentValue,
    @required this.dateExpiration,
    @required this.debtId,
  });

  InstallmentDebts.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    installmentValue = map['installment_value'];
    dateExpiration = DateFormatter().fromDatabase(map['date_expiration']);
    debtId = map['debt_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'installment_value': installmentValue,
      'date_expiration': DateFormatter().toDatabase(dateExpiration),
      'debt_id': debtId,
    };

    return map;
  }
}
