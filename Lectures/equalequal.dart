class Point {
  final int x, y;
  Point(this.x, this.y);
}

void main(){
var a = Point(1, 2);
var b = Point(1, 2);
print(a == b);       // false why?
print(a == a);       // true  why?
}