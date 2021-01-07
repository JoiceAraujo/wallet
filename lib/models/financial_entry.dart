import 'package:flutter/foundation.dart';
import 'package:wallet/utils/date_converter.dart';

class FinancialEntry {
  int id;
  double value;
  String description;
  String entryDate;
  int userId;

  FinancialEntry({
    @required this.value,
    @required this.description,
    @required this.entryDate,
    @required this.userId,
  });

  FinancialEntry.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    value = map['value'];
    description = map['description'];
    entryDate = DateFormatter().fromDatabase(map['entry_date']);
    userId = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'value': value,
      'description': description,
      'entry_date': DateFormatter().toDatabase(entryDate),
      'user_id': userId,
    };

    return map;
  }
}
