import "dart:io";

void main() {
  stdout.write('Input Name: ');
  String? name = stdin.readLineSync();
  stdout.write('Hello ${name}');
}
