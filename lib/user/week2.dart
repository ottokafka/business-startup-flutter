import 'package:intl/intl.dart';

DateTime now = DateTime.parse(DateTime.now().toString());
var dayOfWeek = DateTime.now().weekday;
var m = int.parse(DateFormat.M().format(now));
var y = int.parse(DateFormat.y().format(now));
monday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 6;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 5;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 4;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 3;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 2;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 1;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

tuesday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 6;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 5;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 4;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 3;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 2;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

wednesday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 6;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 5;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 4;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 3;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

thursday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 6;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 5;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 4;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

friday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 6;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 5;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

saturday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 6;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

sunday2() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 7;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}
