// NAMED CONSTRUCTOR
// class Circle {
//   double radius;
//   Circle(this.radius);
//   Circle.Diameter(double d) : radius = d / 2;
//   Circle.initialization() : radius = 0;
//   Circle.semiCircle(double r) : radius = r / 2;
// }

// void main() {
//   var c = Circle.Diameter(15);
//   print('${c.radius}');
//   var c2 = Circle.initialization();
//   print('${c2.radius}');
//   var sC = Circle.semiCircle(16);
//   print("${sC.radius}");
// }

// class Product {
//   final String title;
//   final double price;
//   Product({required this.title, required this.price});
//   Product.fromJSON(Map<String, dynamic> json)
//     : title = json['title'],
//       price = (json['price'] as num).toDouble();
// }

// void main() {
//   var p = Product.fromJSON({'title': 'Nike', 'price': 49.9});
//   print("${p.price} and ${p.title}");
// }

// FACTORY CONSTRUCTOR
// class Teacher {
//   static Teacher? _instance;
//   Teacher._internal();
//   factory Teacher() {
//     return _instance ??= Teacher._internal();
//   }
// }

// void main() {
//   Teacher t1 = Teacher._internal();
//   Teacher t2 = Teacher._internal();
// }

// Assertion
// class Circle {
//   double radius;
//   double area;
//   Circle(this.radius)
//     : area = 3.14 * radius * radius,
//       assert(radius > 0, 'radius must be positive');

// }

// Getters and setters
// class Rectangle {
//   double _width, _height;
//   Rectangle(this._width, this._height);
//   // Getter
//   double get Area => _width * _height;
//   double get Width => this._width;
//   double get Height => this._height;
//   // Setter
//   set Width(double w) {
//     _width = w < 0 ? 0 : w;
//   }

//   set Length(double h) {
//     _height = h < 0 ? 0 : h;
//   }
// }

// void main() {
//   var r = Rectangle(10, 5);
//   r.Width = 19;
//   print("${r.Width}");
// }
