import 'package:flutter/foundation.dart';

class Card {
  int id;
  String nickname;
  double balance;
  String type;
  int userId;

  Card({
    @required this.nickname,
    @required this.balance,
    @required this.type,
    @required this.userId,
  });

  Card.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nickname = map['nickname'];
    balance = map['balance'];
    type = map['type'];
    userId = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'nickname': nickname,
      'balance': balance,
      'type': type,
      'user_id': userId,
    };

    return map;
  }
}
