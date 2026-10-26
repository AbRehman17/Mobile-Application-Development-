class Vector {
  final double x, y;
  Vector(this.x, this.y);

  Vector operator +(Vector o) => Vector(x + o.x, y + o.y);
  Vector operator -(Vector o) => Vector(x - o.x, y - o.y);
  Vector operator *(double k) => Vector(x * k, y * k); // v * 2
  Vector operator -() => Vector(-x, -y); // -v  (unary)
  double operator [](int i) => i == 0 ? x : y; // v[0], v[1]

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
  
  @override 
  String toString ()=> "$x, $y";
}

void main() {
  var a = Vector(1, 2), b = Vector(3, 4);
  var c = a + b; // Vector(4, 6)
  print("Vector c is: $c");
  var d = a * 2; // Vector(2, 4)
  var e = -a; // Vector(-1, -2)
  print(a[0]); // 1.0
  print(a == Vector(1, 2)); // true
}
