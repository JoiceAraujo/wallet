class DatabaseQueries {
  static const String _createTableBalanceHistory = '''
  CREATE TABLE BalanceHistories(
    id INTEGER PRIMARY KEY,
    initial_date TEXT NOT NULL,
    final_date TEXT NOT NULL,
    final_balance REAL NOT NULL,
  );
  ''';

  static const String _createTableUser = '''
  CREATE TABLE Users(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    monthly_income REAL NOT NULL,
    id_balance INTEGER,
    FOREIGN KEY(id_balance) REFERENCES BalanceHistories(id)
  );
  ''';

  static const String _createTableFinancialEntries = '''
  CREATE TABLE FinancialEntries(
    id INTEGER PRIMARY KEY,
    value REAL NOT NULL,
    description TEXT,
    entry_date TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES Users(id)
  );
  ''';

  static const String _createTableDebts = '''
  CREATE TABLE Debts(
    id INTEGER PRIMARY KEY,
    nickname TEXT NOT NULL,
    total_value REAL NOT NULL,
    description TEXT,
    installment_debt INTEGER NOT NULL,
    quantity_instalments INTEGER NOT NULL, 
    type INTEGER NOT NULL,
    status TEXT NOT NULL,
    base_day TEXT NOT NULL,
    payment_method INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES Users(id)
    FOREIGN KEY(payment_method) REFERENCES Cards(id)    
  );
  ''';

  static const String _createTableInstallmentDebts = '''
  CREATE TABLE InstallmentDebts(
    id INTEGER PRIMARY KEY,
    installment_value REAL NOT NULL,
    date_expiration TEXT NOT NULL,
    debt_id INTEGER NOT NULL,
    FOREIGN KEY(debt_id) REFERENCES Debts(id)
  );
  ''';

  static const String _createTableCards = '''
  CREATE TABLE Cards(
    id INTEGER PRIMARY KEY,
    nickname TEXT NOT NULL UNIQUE,
    balance REAL NOT NULL,
    type TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES Users(id)
  );
  ''';

  static const String _createTableCreditCardsDates = '''
  CREATE TABLE CreditCardsDates(
    id INTEGER PRIMARY KEY,
    date_closing TEXT NOT NULL,
    date_expiration TEXT NOT NULL,
    card_id INTEGER NOT NULL,
    FOREIGN KEY(card_id) REFERENCES Cards(id)    
  );
  ''';

  static const List<String> queries = [
    _createTableBalanceHistory,
    _createTableUser,
    _createTableFinancialEntries,
    _createTableCards,
    _createTableCreditCardsDates,
    _createTableDebts,
    _createTableInstallmentDebts,
  ];
}
