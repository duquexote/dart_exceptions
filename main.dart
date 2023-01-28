import 'dart:math';

import 'controllers/bank_controller.dart';
import 'exceptions/bank_controller_excpetions.dart';
import 'models/account.dart';

// Adicionei um comentário
// Mais um comentário para testar o git

void testingNullSafety() {
  Account? myAccount =
      Account(name: "Duque", balance: 20, isAuthenticated: true);

  // Simulando uma conexão externa
  Random rng = Random();
  int randomNumber = rng.nextInt(10);
  print(randomNumber);
  if (randomNumber <= 5) {
    myAccount.createdAt = DateTime.now();
  }

  print(myAccount.runtimeType);

  // Teste forçado que não funciona
  // print(myAccount.balance);
  // print(myAccount.createdAt);
  // print(myAccount.createdAt.day); // Não consigo fazer porque é null

  // Usar essa solução não torna o código seguro
  // print(myAccount!.balance);
  // print(myAccount.createdAt!.day);

  // Torna o código mais seguro com essa solução
  //if (myAccount != null) {
  //  print(myAccount.balance);
  //} else {
  //  print("Conta nula");
  //}

  // Usando o operador ternário torna a resolução curta
  // print(myAccount != null ? myAccount.balance : "Conta nula");

  // "?" Chamado de safecall, é uma resolução mais curta ainda
  // print(myAccount?.balance);
}

void main(List<String> args) {
  testingNullSafety();

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
