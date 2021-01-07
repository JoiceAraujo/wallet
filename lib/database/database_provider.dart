import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet/models/balance_history.dart';
import 'package:wallet/models/user.dart';

import 'database_queries.dart';

class DatabaseProvider {
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  const DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _init();
      return _database;
    }
  }

  Future<Database> _init() async {
    final String documentsDirectory = await getDatabasesPath();
    final String path = join(documentsDirectory, 'Wallet.db');
    final Function onCreateFunction = (Database db, int version) async {
      for (String query in DatabaseQueries.queries) {
        await db.execute(query);
      }
    };

    return await openDatabase(path, version: 1, onCreate: onCreateFunction);
  }

//  User methods
  Future<int> addUser(User user) async {
    final db = await database;

    try {
      return await db.insert('Users', user.toMap());
    } catch (e) {
      print(e);
      return null;
    }
  }

  void updateUser(Map<String, dynamic> value) async {
    final db = await database;

    try {
      db.update('Users', value, where: 'id = ?', whereArgs: [0]);
    } catch (e) {
      print(e);
    }
  }

//  Balance history methods
  Future<int> addBalanceHistory(BalanceHistory balance) async {
    final db = await database;

    try {
      return await db.insert('BalanceHistories', balance.toMap());
    } catch (e) {
      print(e);
      return null;
    }
  }

  void updateFinalBalance(Map<String, dynamic> value, int id) async {
    final db = await database;

    try {
      db.update('BalanceHistories', value, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getBalanceById(int id) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'BalanceHistories',
        where: 'id = ?',
        whereArgs: [id],
      );

      return result.first;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getBalanceByPeriod(
      String initialDate, String finalDate) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'BalanceHistories',
        where: 'initial_date = ? AND final_date = ?',
        whereArgs: [initialDate, finalDate],
      );

      return result.first;
    } catch (e) {
      print(e);
      return null;
    }
  }

//  Financial entries methods

//  Cards methods

//  Credit cards dates methods

//  Debts methods

//  Installment debts methods
}
