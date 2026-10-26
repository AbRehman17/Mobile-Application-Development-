import 'dart:io';

void main() {
  stdout.writeln('Hello to Dart');
  final now = DateTime.now();
  print("System time at program start was: $now");
  String? input = stdin.readLineSync();
  print("Read line from console: $input");

  final then = DateTime.now();
  print("System time at program termination is: $then");
  print("**********************");
  print("program ended in: ${then.difference(now)} seconds");
}
