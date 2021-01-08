import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet/models/balance_history.dart';
import 'package:wallet/models/card.dart';
import 'package:wallet/models/credit_card_date.dart';
import 'package:wallet/models/debt.dart';
import 'package:wallet/models/financial_entry.dart';
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
      await db.update('Users', value, where: 'id = ?', whereArgs: [0]);
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
      await db
          .update('BalanceHistories', value, where: 'id = ?', whereArgs: [id]);
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

  Future<List<Map<String, dynamic>>> getBalanceByPeriod(
      String initialDate, String finalDate) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'BalanceHistories',
        where: 'initial_date = ? AND final_date = ?',
        whereArgs: [initialDate, finalDate],
      );

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

//  Financial entries methods
  Future<int> addFinancialEntry(FinancialEntry financialEntry) async {
    final db = await database;

    try {
      return await db.insert('FinancialEntries', financialEntry.toMap());
    } catch (e) {
      print(e);
      return null;
    }
  }

  void deleteFinancialEntry(int id) async {
    final db = await database;

    try {
      await db.delete('FinancialEntries', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllFinancialEntries() async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'FinancialEntries',
        groupBy: 'entry_date',
      );

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getFinancialEntriesByPeriod(
      String initialDate, String finalDate) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'FinancialEntries',
        where: 'entry_date >= ? AND entry_date <= ?',
        whereArgs: [initialDate, finalDate],
        groupBy: 'entry_date',
      );

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

//  Cards methods
  Future<int> addCard(Card card) async {
    final db = await database;

    try {
      return await db.insert('Cards', card.toMap());
    } catch (e) {
      print(e);
      return null;
    }
  }

  void updateCard(Map<String, dynamic> value, int id) async {
    final db = await database;

    try {
      await db.update('Cards', value, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllCards() async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query('Cards');

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getCardById(int id) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'Cards',
        where: 'id = ?',
        whereArgs: [id],
      );

      return result.first;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void deleteCard(int id) async {
    final db = await database;

    try {
      await db.delete(
        'Cards',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }

//  Credit cards dates methods
  Future<int> addCreditCardDate(CreditCardDate creditCardDate) async {
    final db = await database;

    try {
      return await db.insert('CreditCardsDates', creditCardDate.toMap());
    } catch (e) {
      print(e);
      return null;
    }
  }

  void updateCreditCardDate(Map<String, dynamic> value, int id) async {
    final db = await database;

    try {
      await db.update(
        'CreditCardsDates',
        value,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllCreditCardsDates() async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query('CreditCardsDates');

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

//  Debts methods
  Future<int> addDebt(Debt debt) async {
    final db = await database;

    try {
      return await db.insert('Debts', debt.toMap());
    } catch (e) {
      print(e);
      return null;
    }
  }

  void deleteDebt() {}

  void updateDebt() {}

  void getDebtsByPeriod() {}
  //  Installment debts methods
}
