import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/balance_history.dart';
import '../models/bank_card.dart';
import '../models/credit_card_date.dart';
import '../models/debt.dart';
import '../models/financial_entry.dart';
import '../models/installment_debt.dart';
import '../models/user.dart';
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
  Future<int> addCard(BankCard card) async {
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

  Future<Map<String, dynamic>> getCreditCardDatesByCardId(int cardId) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'CreditCardsDates',
        where: 'card_id = ?',
        whereArgs: [cardId],
      );

      return result.first;
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

  void deleteDebt(int id) async {
    final db = await database;

    try {
      await db.delete('Debts', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  void updateDebt(Map<String, dynamic> value, int id) async {
    final db = await database;

    try {
      await db.update('Debts', value, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getDebtsByPeriod(
      String initialDate, String finalDate) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'Debts',
        where: 'base_day >= ? AND base_day <= ?',
        whereArgs: [initialDate, finalDate],
      );

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getDebtById(int id) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'Debts',
        where: 'id = ?',
        whereArgs: [id],
      );

      return result.first;
    } catch (e) {
      print(e);
      return null;
    }
  }

// Installment debts methods
  Future<List<int>> addInstallmentDebts(
      List<InstallmentDebt> installments) async {
    final db = await database;
    List<int> installmentsIds = [];

    try {
      for (InstallmentDebt instalment in installments) {
        installmentsIds
            .add(await db.insert('InstallmentDebts', instalment.toMap()));
      }

      return installmentsIds;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getInstallmentsByDebtId(int debtId) async {
    final db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        'InstallmentDebts',
        where: 'debt_id = ?',
        whereArgs: [debtId],
      );

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
