abstract class Shape{
double area(); // no body
}

class Circle implements Shape{

final double radius;
Circle(this.radius);

@override
double area()=> 3.1415 * radius * radius;
}

void main(){

var c = Circle(2.2);
print(c.area());
}