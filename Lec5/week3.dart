// Week3.dart  -  Library Desk Assistant // Name: Muhammad Hussain Abdulrehman   Roll no:04072313047
final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];
void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  final books = ['Dart in Action', 'Clean Code'];

  final upperCase = transformAll(books, (item) {
    return item.toUpperCase();
  });

  print(upperCase);

  final withExclamation = transformAll(books, (item) => '$item!');

  print(withExclamation);

  final desk1 = makeCounter();
  final desk2 = makeCounter();

  print(desk1());
  print(desk1());
  print(desk1());

  print(desk2());
  final studentFee = makeFeeCalculator(0.25);
  final staffFee = makeFeeCalculator(0.10);

  print(studentFee(4));
  print(staffFee(4));
  print(sumDigits(1234));
}

void part3() {
  print('--- Part 3 ---');
  final titles = books.map((b) => b['title'] as String).toList();
  print('Titles: $titles');
  final available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Available: $available');
  final totalCopies = books.fold(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');
  final years = books.map((b) => b['year'] as int).toList();
  final oldestYear = years.reduce((a, b) => a < b ? a : b);
  print('Oldest year: $oldestYear');
  final sortedBooks = List.of(books);
  sortedBooks.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));
  final byYear = sortedBooks.map((b) => b['title'] as String).toList();
  print('By year: $byYear');
  final stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });
  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');
  final allTags = {for (final b in books) ...(b['tags'] as List<String>)};
  print('All tags: $allTags');
  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');
  final intBox = Box<int>(5);
  final stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}'); // intBox.value = 'hello'; print(firstOr( ['Dart in Action', 'Clean Code'], 'none', )); print(firstOr<String>([], 'z')); print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');
  var stock = buildStock();
  for (final title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book.');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');
  print('Fetching...');
  final book = await fetchBookOfTheDay();
  print('Book of the day: $book');
  try {
    final result = await fetchBroken();
    print(result);
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// ==================== Part 1 Functions ====================
double? lateFee(int daysLate, double ratePerDay) => 3 * ratePerDay;
String? formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }
  return '${title} by ${author}';
}

Map<String, dynamic>? makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool? isClassic(int year) {
  if (year < 2000) return true;
  return false;
}

// ==================== Part 2 Functions ====================
List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

int Function() makeCounter() {
  int count = 0;

  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) {
    return n;
  }

  return (n % 10) + sumDigits(n ~/ 10);
}

// ==================== Part 3 Functions ====================
Map<String, int> buildStock() {
  return {for (final b in books) b['title'] as String: b['copies'] as int};
}

// ==================== Part 4 Functions ====================
class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  if (items.isNotEmpty) {
    return items.first;
  }
  return fallback;
}

class Pair<A, B> {
  A first;
  B second;
  Pair(this.first, this.second);
  @override
  String toString() {
    return '($first, $second)';
  }
}

// ==================== Part 5 Functions ====================
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((book) => book['title'] == title);
}

// ==================== Part 6 Functions ====================
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}
// 1. I would choose fold when I need to provide an initial value or when the list might be empty.
// reduce requires the list to contain at least one element.

// 2. A closure captures a variable when it remembers and can use that variable even after the outer function has finished.
// In makeCounter, the closure captures the count variable.

// 3. BookNotAvailableException must come before a general catch (e) because the specific exception should be handled first.
// A general catch would catch the exception before the specific on clause could handle it.

// 4. Forgetting await still compiles because fetchBookOfTheDay() returns a valid Future<String>.
// Without await, we get the Future object instead of the actual String result.
