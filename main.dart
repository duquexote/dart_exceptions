import 'controllers/bank_controller.dart';
import 'exceptions/bank_controller_excpetions.dart';
import 'models/account.dart';

// Adicionei um comentário
// Mais um comentário para testar o git
void main(List<String> args) {
  BankController bankController = BankController();

  bankController.addAccount(
      id: "Ricarth",
      account:
          Account(name: "Ricarth Lima", balance: 600, isAuthenticated: true));

  bankController.addAccount(
      id: "Duque",
      account:
          Account(name: "Guilherme Duque", balance: 39, isAuthenticated: true));

  try {
    bool result = bankController.makeTransfer(
        idSender: "Ricarth", idReceiver: "Duque", amount: 700);
    if (result) {
      print("Transação concluída!");
    }
  } on SenderIdInvalidException catch (e) {
    print(e);
    print("O ID '${e.idSender}' do remetente não é válido!");
  } on ReceiverIdInvalidException catch (e) {
    print(e);
    print("O ID '${e.idReceiver}' do destinatário não é válido!");
  } on SenderNotAuthenticatedException catch (e) {
    print(e);
    print("O usuário remetente de ID ${e.idSender} não está autenticado!");
  } on ReceiverNotAuthenticatedException catch (e) {
    print(e);
    print("O usuário destinatário de ID ${e.idReceiver} não está autenticado!");
  } on SenderBalanceLowerThanAmountException catch (e) {
    print(e);
    print(
        "O usuário de ID '${e.idSender}' tentou enviar ${e.amount} sendo que sua conta tem apenas ${e.senderBalance}");
  }
}
