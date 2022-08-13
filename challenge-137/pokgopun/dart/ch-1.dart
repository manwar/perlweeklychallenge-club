void main() {
  int startY = 1900;
  int endY = 2100;
  var longYear = <int>[];
  for (var y = startY; y <= endY; y++) {
    var t = DateTime(y, DateTime.january, 1);
    for (var wd in <int>[
      t.weekday,
      t.add(Duration(days: y % 4 == 0 ? 365 : 364)).weekday
    ]) {
      if (wd == DateTime.thursday) {
        longYear.add(y);
        break;
      }
    }
  }
  print(longYear);
}
