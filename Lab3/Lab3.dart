// lab3.dart - Campus Cafe Order System
// Name: Muhammad Husssain Abdul Rehman
// Roll no: 04072313047

const String rollNo = '04072313047';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t;

final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

// ============================================================================
// CLASSES
// ============================================================================

// Step 1: Dish
class Dish {
  late String name;
  late int price;
}

// Step 2 & 3: MenuItem
class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
  MenuItem.free(this.name) : price = 0;
  MenuItem.fromString(text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);

  // Step 8
  @override
  String toString() => '$name (Rs $price)';
}

// Step 4: OrderLog
class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];
  OrderLog._internal();
  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }
  void add(String msg) => entries.add(msg);
}

// Step 5 & 6: OrderLine
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = item.price * qty * taxPercent ~/ 100,
      assert(qty > 0, 'qty must be positive');

  int get grand => total + tax;

  bool get isBigOrder => grand > bigOrderLimit;

  String get label => '${item.name} x$qty';
}

// Step 7: StudentCard
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

// Step 10: Coupon
class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50, 'percent must be 1..50');

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }
    return 0;
  }
}

// ============================================================================
// TOP-LEVEL FUNCTIONS
// ============================================================================

// Step 5
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

// Step 8
List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

// Step 9
List<OrderLine> buildReceipt() {
  var items = buildMenu();
  return [for (int k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

// ============================================================================
// MAIN
// ============================================================================

void main() {
  print('Seed: $seed (t=$t, u=$u)');

  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

// ============================================================================
// STEP 1
// ============================================================================
void step1() {
  print('--- Step 1 ---');
  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);
  Dish item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);
  item2.price = item2.price - u;
  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

// ============================================================================
// STEP 2
// ============================================================================
void step2() {
  print('--- Step 2 ---');
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Test Special', 15 * u);
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: ${b.name} Rs ${b.price}');
  // Question
  // Why could price not be declared final in this version?
  // price cannot be final because its value may be changed in the constructor body.
  // If the price is below priceFloor, we update it to priceFloor.
}

// ============================================================================
// STEP 3
// ============================================================================
void step3() {
  print('--- Step 3 ---');
  MenuItem freebie = MenuItem.free('Water');
  var i = (u + 2) % 10;
  MenuItem parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=${priceFloor}, free price=${freebie.price}');
  // Question
  // The floor is, say, 80 but free() produced 0. Why did the floor logic not run?
  // free() is a separate named constructor, so the default constructor
  // body (which contains the floor check) never runs. Its initializer
  // list sets price = 0 directly, bypassing the floor.
}

// ============================================================================
// STEP 4
// ============================================================================
void step4() {
  print('--- Step 4 ---');
  var log1 = OrderLog();
  var log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }
  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
  // Question
  // Why do _instance and _internal start with an underscore? What could go wrong if they did not?
  // The underscore makes them private to the file. If they were public:
  // 1. Outside code could call OrderLog._internal() and create a second
  //    instance, breaking the singleton.
  // 2. Outside code could set OrderLog._instance = null, wiping the cache.
}

// ============================================================================
// STEP 5
// ============================================================================
void step5() {
  print('--- Step 5 ---');
  var line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0); // qty = 0 → assert should fire
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
  // Question
  // Try writing tax = total * taxPercent ~/ 100. Read the error. Why can an initializer list not read another field of the same object?
  // Initializer lists run before the object exists, so they can't read
  // other fields of the same object — only constructor parameters.
}

// ============================================================================
// STEP 6
// ============================================================================
void step6() {
  print('--- Step 6 ---');
  var line = mainOrder();
  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
  //  Why does that line fail? What would you have to add to make it legal?
  // grand is a getter (no setter), so it can be read but not assigned.
  // Add `set grand(int v) { ... }` to make the assignment compile.
}

// ============================================================================
// STEP 7
// ============================================================================
void step7() {
  print('--- Step 7 ---');
  var card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');

  // Think:
  // What else could a setter do with an invalid value?
  // Instead of silently clamping, a setter could throw an exception
  // (e.g. ArgumentError) so the caller knows the value was rejected. It
  // could also log a warning, ignore the assignment, or round the value.
}

// ============================================================================
// STEP 8
// ============================================================================
void step8() {
  print('--- Step 8 ---');
  var items = buildMenu();
  var priciest = items.reduce((a, b) => a.price > b.price ? a : b);
  var sum = items.fold<int>(0, (acc, item) => acc + item.price);
  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

// ============================================================================
// STEP 9
// ============================================================================
void step9() {
  print('--- Step 9 ---');
  var lines = buildReceipt();
  var log = OrderLog();

  var total = 0;
  for (var line in lines) {
    print('Step 9: ${line.label} = ${line.grand}');
    log.add('receipt: ${line.label}');
    total += line.grand;
  }

  print('Step 9: receipt total = $total');
  print('Step 9: log size = ${log.entries.length}');
}

// ============================================================================
// STEP 10
// ============================================================================
void step10() {
  print('--- Step 10 ---');
  var code = 'CAFE${seed.toString().padLeft(2, '0')}';

  var c1 = Coupon.fromCode(code);
  var c2 = Coupon.fromCode(code);

  var receipt = 0;
  for (var line in buildReceipt()) {
    receipt += line.grand;
  }

  var discount = c1.discountOn(receipt);
  print(
    'Step 10: ${c1.code} gives ${c1.percent}% off, min spend ${c1.minSpend}',
  );
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receipt, discount $discount, payable ${receipt - discount}',
  );
}

// ============================================================================
// REFLECTION QUESTIONS
// Q1. What does constructor shorthand save you?
// It saves you from writing `this.x = x;` for every field — one line instead
// of two per parameter.
//
// Q2. When would you choose a named constructor,and when a factory constructor?
// Named: when you want a clear alternative way to build an object
// (e.g. fromString, free). Factory: when you might return an existing
// instance (cache/singleton) or a subtype instead of always creating new.
//
// Q3. What is the difference between assigning a field in a constructor body and an initializer list?
// Initializer list runs before the object exists, can set final fields,
// and can only read constructor parameters. The body runs after the object
// exists, can read other fields, but cannot assign final fields.
//
// Q4. Give one reason to use a getter instead of a field, and one reason to use a setter instead of a public field.
// Getter: value is computed on demand and stays consistent with other
// fields (e.g. grand = total + tax). Setter: allows validation/clamping
// so callers cannot put the object in an invalid state.
// ============================================================================
