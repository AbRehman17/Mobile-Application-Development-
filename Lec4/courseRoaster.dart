import "dart:io";

void printWelcome(String appName) {
  stdout.writeln('=== ${appName} ===');
}

String generateCode(String title) =>
    title.substring(0, 2).toUpperCase() + '101';

void main() {
  // Part 1: Setup & Welcome
  String appName = 'Course Roster Manager';
  printWelcome('=== $appName ===');

  // Part 2: Course & Roster Data
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};
  print(
    'Title: $courseTitle \nCapacity: $capacity \nEnrolled Students: $enrolledStudents',
  );

  // Part 3: Null-Safe Instructor Info
  String? instructorEmail;
  print(instructorEmail ?? 'TBA');
  late String enrollmentCode;
  const title = "Mobile Dev";
  enrollmentCode = generateCode(title);
  print("Enrollment Code: $enrollmentCode");
  // // Crash
  // print(instructorEmail!.length);
  //Safe Version
  print(instructorEmail?.length ?? 3);

  // Part 4: Formatting Strings
  String rawNames = ' Aiden , maria ,JAMAL , Priya ';
  List<String> names = rawNames.split(',');
  List<String> cleanNames = [];
  for (String name in names) {
    cleanNames.add(name.trim());
  }
  print('Names: $names');
  print('Cleaned Names: $cleanNames');
  String courseDescription = '''
CS201: Mobile App Development
Credit Hours: 3
Capacity: 4 students
''';
  print(courseDescription);
  print('Seats left: ${capacity - enrolledStudents.length}');

  // Part 5: Operators in Action
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups \nleftover: $leftover');
  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('formInput is a String');
  }
  if (formInput is! int) {
    print('formInput is not an int');
  }
  StringBuffer report = StringBuffer()
    ..write('Report: $courseTitle \n')
    ..write('Cap: $capacity \n')
    ..write('Roster: ${enrolledStudents.length}');
  print(report.toString());
  List<String>? extraNotes;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');
  int? bonusSeats;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');

  // Part 6: Enrollment Logic
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Sorry, enrollment is closed or the course is full.');
  }

  int enrollmentStatusCode = 200;

  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  // Part 7: Reports & Loops

  for (String student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((key, value) {
    print('$key: $value');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];

  for (String announcement in announcements) {
    print(announcement);
  }

  print('Created at: $createdAt');
  print('Credit hours: $creditHours');
}
