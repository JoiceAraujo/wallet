import 'package:flutter/foundation.dart';

class FinancialEntries {
  int id;
  double value;
  String description;
  String entryDate;
  int user;

  FinancialEntries({
    @required this.value,
    @required this.description,
    @required this.entryDate,
    @required this.user,
  });

  FinancialEntries.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    value = map['value'];
    description = map['description'];
    entryDate = map['entry_date'];
    user = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'value': value,
      'description': description,
      'entry_date': entryDate,
      'user_id': user,
    };

    return map;
  }
}
