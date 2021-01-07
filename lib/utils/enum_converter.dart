import 'package:wallet/utils/constants.dart';

class EnumConverter {
  DebtType debtTypeFromDatabase(int type) {
    if (DebtType.Services.index == type) {
      return DebtType.Services;
    } else if (DebtType.Supermarket.index == type) {
      return DebtType.Supermarket;
    } else if (DebtType.CreditCard.index == type) {
      return DebtType.CreditCard;
    } else if (DebtType.Academy.index == type) {
      return DebtType.Academy;
    } else if (DebtType.House.index == type) {
      return DebtType.House;
    } else if (DebtType.Transport.index == type) {
      return DebtType.Transport;
    } else if (DebtType.Recreation.index == type) {
      return DebtType.Recreation;
    } else if (DebtType.Restaurant.index == type) {
      return DebtType.Restaurant;
    } else if (DebtType.Savings.index == type) {
      return DebtType.Savings;
    } else if (DebtType.Others.index == type) {
      return DebtType.Others;
    } else {
      return null;
    }
  }

  int debtTypeToDatabase(DebtType type) {
    if (DebtType.Services == type) {
      return DebtType.Services.index;
    } else if (DebtType.Supermarket == type) {
      return DebtType.Supermarket.index;
    } else if (DebtType.CreditCard == type) {
      return DebtType.CreditCard.index;
    } else if (DebtType.Academy == type) {
      return DebtType.Academy.index;
    } else if (DebtType.House == type) {
      return DebtType.House.index;
    } else if (DebtType.Transport == type) {
      return DebtType.Transport.index;
    } else if (DebtType.Recreation == type) {
      return DebtType.Recreation.index;
    } else if (DebtType.Restaurant == type) {
      return DebtType.Restaurant.index;
    } else if (DebtType.Savings == type) {
      return DebtType.Savings.index;
    } else if (DebtType.Others == type) {
      return DebtType.Others.index;
    } else {
      return null;
    }
  }

  DebtStatus debtStatusFromDatabase(int status) {
    if (DebtStatus.Paid.index == status) {
      return DebtStatus.Paid;
    } else if (DebtStatus.Pending.index == status) {
      return DebtStatus.Pending;
    } else {
      return null;
    }
  }

  int debtStatusToDatabase(DebtStatus status) {
    if (DebtStatus.Paid == status) {
      return DebtStatus.Paid.index;
    } else if (DebtStatus.Pending == status) {
      return DebtStatus.Pending.index;
    } else {
      return null;
    }
  }

  CardType cardTypeFromDatabase(int type) {
    if (CardType.Credit.index == type) {
      return CardType.Credit;
    } else if (CardType.Debit.index == type) {
      return CardType.Debit;
    } else {
      return null;
    }
  }

  int cardTypeToDatabase(CardType type) {
    if (CardType.Credit == type) {
      return CardType.Credit.index;
    } else if (CardType.Debit == type) {
      return CardType.Debit.index;
    } else {
      return null;
    }
  }
}
