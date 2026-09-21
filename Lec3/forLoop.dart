void printName(String name) {
  print('My name is ${name} \n');
}

void main() {
  List<String> names = ['mani', 'umais', "aitzaz", "abubakr"];
  for (var name in names) {
    printName(name);
  }
}
