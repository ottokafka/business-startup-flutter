import 'package:intl/intl.dart';

DateTime now = DateTime.parse(DateTime.now().toString());
var dayOfWeek = DateTime.now().weekday;
var m = int.parse(DateFormat.M().format(now));
var y = int.parse(DateFormat.y().format(now));
monday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 8;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

tuesday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 15;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 9;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

wednesday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 16;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 15;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 10;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

thursday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 17;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 16;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 15;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 11;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

friday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 18;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 17;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 16;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 15;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 12;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

saturday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 19;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 18;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 17;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 16;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 15;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 13;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}

sunday3() {
  if (dayOfWeek == 1) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 20;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 2) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 19;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 3) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 18;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 4) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 17;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 5) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 16;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 6) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 15;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
  if (dayOfWeek == 7) {
    int d = int.parse(DateFormat.d().format(now));
    d = d + 14;
    var date = DateFormat('yyyy-MM-dd').format(DateTime.utc(y, m, d));
    print(date);
    return date;
  }
}
