import '../exceptions/bank_controller_excpetions.dart';
import '../models/account.dart';

class BankController {
  final Map<String, Account> _database = {};

  addAccount({required String id, required Account account}) {
    _database[id] = account;
  }

  // Faz a transferencia de dinheiro de uma conta para outra
  bool makeTransfer(
      {required String idSender,
      required String idReceiver,
      required double amount}) {
    
    // Verifica se existe o ID do remetente
    if (!verifyId(idSender)) {
      throw SenderIdInvalidException(idSender: idSender);
    }

    // Verifica se existe o ID do destinatário
    if (!verifyId(idReceiver)) {
      throw ReceiverIdInvalidException(idReceiver: idReceiver);
    }
    
    Account accountSender = _database[idSender]!;
    Account accountReceiver = _database[idReceiver]!;

    if (!accountSender.isAuthenticated) {
      throw SenderNotAuthenticatedException(idSender: idSender);
    }

    if (!accountReceiver.isAuthenticated) {
      throw ReceiverNotAuthenticatedException(idReceiver: idReceiver);
    }
    
    // Verifica se o remetente tem saldo suficiente para enviar o dinheiro
    if (accountSender.balance < amount) {
      throw SenderBalanceLowerThanAmountException(idSender: idSender, senderBalance: accountSender.balance, amount: amount);
    }

    accountSender.balance -= amount;
    accountReceiver.balance += amount;

    return true;
  }

  bool verifyId(String id) {
    return _database.containsKey(id);
  }
}
