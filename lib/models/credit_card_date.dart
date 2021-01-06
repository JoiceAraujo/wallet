import 'package:flutter/foundation.dart';

import '../utils/date_formatter.dart';

class CreditCardDate {
  int id;
  String dateClosing;
  String dateExpiration;
  int cardId;

  CreditCardDate({
    @required this.dateClosing,
    @required this.dateExpiration,
    @required this.cardId,
  });

  CreditCardDate.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dateClosing = DateFormatter().fromDatabase(map['date_closing']);
    dateExpiration = DateFormatter().fromDatabase(map['date_expiration']);
    cardId = map['card_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'date_closing': DateFormatter().toDatabase(dateClosing),
      'date_expiration': DateFormatter().toDatabase(dateExpiration),
      'card_id': cardId,
    };

    return map;
  }
}
