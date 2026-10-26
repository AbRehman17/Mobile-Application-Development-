abstract class PaymentMethod {
  void pay(double amount); // the contract: no body
}

class Card extends PaymentMethod {
  @override
  void pay(double amount) => print('Charging $amount to the card');
}

class Wallet extends PaymentMethod {
  @override
  void pay(double amount) => print('Deducting $amount from the wallet');
}

class Cash extends PaymentMethod {
  @override
  void pay(double amount) => print('Collect $amount at the door');
}

void checkout(PaymentMethod method, double total) {
  method.pay(total); // works for ANY payment method
}

void main() {
  checkout(Card(), 50);
  checkout(Wallet(), 50);
  checkout(Cash(), 50);
}
