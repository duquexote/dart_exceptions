class Account {
  String name;
  double balance;
  bool isAuthenticated;
  DateTime? createdAt;

  Account(
      {required this.name,
      required this.balance,
      required this.isAuthenticated,
      this.createdAt});

  editBalance({required value}) {
    balance = balance + value;
  }

  @override
  String toString() {
    return "Nome: ${this.name}, Saldo: ${this.balance}, Autenticado: ${this.isAuthenticated}";
  }
}
