// library_lab.dart  -  Campus Library System
// Name: Muhammad Hussain AbdulRehman   Roll no: 04072313047

const String rollNo = '04072313047'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

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

abstract class LibraryItem {
  final String title;
  final int year;
  static int created = 0;
  static int capFee(int fee) {
    return fee > feeCap ? feeCap : fee;
  }

  LibraryItem(this.title, this.year) {
    created++;
  }
  String describe() => '$title ($year)';
  int lateFee(int days);
}

List<LibraryItem> buildShelf() {
  List<LibraryItem> shelf = [];

  for (int k = 0; k < shelfSize; k++) {
    int i = (u + k) % 10;

    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }

  return shelf;
}

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;
  Book(super.title, super.year, this.pages);
  @override
  String describe() => '${super.describe()}, ${pages} pages';
  @override
  int lateFee(int days) => days * feePerDay;
  @override
  bool get isAvailable => !_out;
  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

class Magazine extends LibraryItem {
  final int issue;
  Magazine(super.title, super.year, this.issue);
  @override
  String describe() => '${super.describe()}, issue ${issue}';
  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

class Dvd extends LibraryItem with Renewable {
  final int minutes;
  Dvd(super.title, super.year, this.minutes);
  @override
  String describe() => '${super.describe()},${minutes} minutes';
  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}

enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) {
    return fee - (fee * discountPercent ~/ 100);
  }
}

extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
}

class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine o) {
    return Fine(amount + o.amount);
  }

  bool operator >(Fine o) {
    return amount > o.amount;
  }

  @override
  bool operator ==(Object other) {
    return other is Fine && other.amount == amount;
  }

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    int fee = item.lateFee(days);
    fee = LibraryItem.capFee(fee);
    fee = type.applyDiscount(fee);
    return Fine(fee);
  }
}

void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  LibraryItem item = b;
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
  // What would happen to the output if you forgot @override and mistyped the method name as descibe()?
  // If we mistype describe() as descibe(), it will not override the parent method. @override helps the analyzer catch this mistake.
}

void step3() {
  print('--- Step 3 ---');
  print(
    'Step 3: Book late fee for ${daysLate} days = ${mainBook().lateFee(daysLate)}',
  );
  print(
    'Step 3: Magazine late fee for ${daysLate} days= ${mainMagazine().lateFee(daysLate)}',
  );
  print(
    'Step 3: Dvd late fee for ${daysLate} days= ${mainDvd().lateFee(daysLate)}',
  );
  // Temporarily try LibraryItem('x', 2000). Read the error. Why can you not create an abstract class directly?
  // An abstract class cannot be instantiated directly because it may contain methods without implementations that subclasses must provide.
}

void step4() {
  print('--- Step 4 ---');
  Book book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');
  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (var item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }
  // You wrote all three method bodies yourself. What would extends Borrowable have given you for free, and why is that not what you wanted?
  // Extending Borrowable would inherit its implementations, if provided.
  // Here we want a contract, so implements makes Book define all required members itself rather than inheriting Borrowable's behavior.
}

void step5() {
  print('--- Step 5 ---');
  Book book = mainBook();
  int ok = 0;
  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }
  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
  //  Book and Dvd need the same renew code but Magazine must not have it. Why is a mixin a better fit than putting renew in LibraryItem?
  // A mixin lets Book and Dvd share renewal code without making Magazine
  // renewable. Putting renew() in LibraryItem would expose it to all items.
}

void step6() {
  print('--- Step 6 ---');
  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');
}

void step7() {
  print('--- Step 7 ---');
  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  int discountedFee = type.applyDiscount(fee);
  print('Step 7: ${discountedFee.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];
  int total = shelf.totalLateFee(daysLate);
  print('Step 7: shelf fee for $daysLate days = ${total.rs}');
}

void step8() {
  print('--- Step 8 ---');

  Fine f1 = Fine(mainBook().lateFee(daysLate));
  Fine f2 = Fine(mainMagazine().lateFee(daysLate));

  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');
  // Delete your hashCode and run again. What happens to the set size,
  // and why does Dart expect both == and hashCode together?
  // If hashCode is removed, equal Fine objects can have different
  // identity-based hash codes, so a Set may count them separately.
  // Dart expects == and hashCode together: equal objects must have
  // the same hash code for Set and Map lookups to work correctly.
}

void step9() {
  print('--- Step 9 ---');
  LibraryItem.created = 0;
  buildShelf(); // pehli shelf — discard
  List<LibraryItem> shelf = buildShelf(); // doosri shelf — keep
  print('Step 9: items created = ${LibraryItem.created}');
  print(
    'Step 9: capped fee = ${LibraryItem.capFee(shelf.first.lateFee(daysBig))} '
    '(cap $feeCap)',
  );
  print(
    'Step 9: const copies identical? ${identical(const Fine(10), const Fine(10))}',
  );
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');
  // Why can created be read as LibraryItem.created without
  // making any object first?
  // created can be read as LibraryItem.created without making any object
  // first because static members belong to the class itself, not to any
  // instance. They are initialized once when the class is loaded, so you
  // can access them directly through the class name.
}

void step10() {
  print('--- Step 10 ---');
  List<LibraryItem> shelf = buildShelf();
  Member member = Member('S$seed', MemberType.values[seed % 3]);
  Fine total = shelf.fold(
    Fine(0),
    (Fine sum, LibraryItem item) => sum + member.feeFor(item, daysLate),
  );
  int borrowable = 0;
  int renewable = 0;
  for (var item in shelf) {
    if (item is Borrowable) borrowable++;
    if (item is Renewable) renewable++;
  }
  print(
    'Step 10: ${shelf.length} items, $borrowable borrowable, $renewable renewable',
  );
  print('Step 10: ${member.name} (${member.type.name}) owes $total');
  print('Step 10: over the cap? ${total > Fine(feeCap)}');
  // one polymorphic loop over a List<LibraryItem> handles Books, Magazines and Dvds
  // with no if on the type.
  // The polymorphic loop works because lateFee() is declared abstract in
  // LibraryItem and each subclass provides its own implementation. Dart
  // dispatches the call at runtime based on the actual object type, so no
  // if/else on type is needed. The 'is' checks are only for counting
  // borrowable and renewable items — not for fee calculation.
}
