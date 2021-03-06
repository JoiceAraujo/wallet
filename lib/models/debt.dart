import 'package:flutter/foundation.dart';

import '../utils/constants.dart';
import '../utils/enum_converter.dart';

class Debt {
  int id;
  int nickname;
  double totalValue;
  String description;
  bool installmentDebt;
  int quantityInstalments;
  DebtType type;
  DebtStatus status;
  String baseDay;
  int paymentMethodId;
  int userId;

  Debt({
    @required this.nickname,
    @required this.totalValue,
    @required this.description,
    @required this.installmentDebt,
    @required this.quantityInstalments,
    @required this.type,
    @required this.status,
    @required this.baseDay,
    @required this.paymentMethodId,
    @required this.userId,
  });

  Debt.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nickname = map['nickname'];
    totalValue = map['total_value'];
    description = map['description'];
    installmentDebt = map['installment_debt'] == 0 ? true : false;
    quantityInstalments = map['quantity_instalments'];
    type = EnumConverter().debtTypeFromDatabase(map['type']);
    status = EnumConverter().debtStatusFromDatabase(map['status']);
    baseDay = map['base_day'];
    paymentMethodId = map['payment_method'];
    userId = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'nickname': nickname,
      'total_value': totalValue,
      'description': description,
      'installment_debt': installmentDebt == true ? 0 : 1,
      'quantity_instalments': quantityInstalments,
      'type': EnumConverter().debtTypeToDatabase(type),
      'status': EnumConverter().debtStatusToDatabase(status),
      'base_day': baseDay,
      'payment_method': paymentMethodId,
      'user_id': userId,
    };

    return map;
  }
}
