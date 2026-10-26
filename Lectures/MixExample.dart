class Animal {}

//******************mixin at work*******************

mixin Flyer {
  void fly() => print('Flying!!!');
}
//**********************Main Method******

class Bird extends Animal with Flyer {}

class Plane with Flyer {}

//********************void main***************

void main() {
  Bird().fly();
  Plane().fly();
}
