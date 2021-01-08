import 'package:flutter/foundation.dart';
import 'package:wallet/utils/constants.dart';
import 'package:wallet/utils/enum_converter.dart';

class BankCard {
  int id;
  String nickname;
  double balance;
  CardType type;
  int userId;

  BankCard({
    @required this.nickname,
    @required this.balance,
    @required this.type,
    @required this.userId,
  });

  BankCard.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nickname = map['nickname'];
    balance = map['balance'];
    type = EnumConverter().cardTypeFromDatabase(map['type']);
    userId = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'nickname': nickname,
      'balance': balance,
      'type': EnumConverter().cardTypeToDatabase(type),
      'user_id': userId,
    };

    return map;
  }
}
