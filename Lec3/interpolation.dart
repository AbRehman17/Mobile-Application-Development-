void main() {
  String wallet = 'leather';
  int priceA = 20;
  int priceB = 15;

  // 1. Accessing an object property (.length)
  print('The word wallet has ${wallet.length} characters.');
  // Output: The word wallet has 7 characters.

  // 2. Evaluating a mathematical expression
  print('The total cost is \$${priceA + priceB}.');
  // Output: The total cost is $35.

  String language = "Dart";
  print("I love coding in $language");

  int qty = 25;
  double price = 75.5;

  print('Total price is: \$ ${qty * price}.');

  print(r'C:\new_folder');
  var d =
      "A quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dogA quick brown fox jumps over the lazy dog";
  print("Multiline String: $d");

  var e = 'Adam is good';
  var f;
  if (e.isEmpty) print(e.split(' '));
  //print("e after split is:  $f");
}
