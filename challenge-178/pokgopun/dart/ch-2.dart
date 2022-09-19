void main(List<String> args) {
  var t = DateTime(2022, 8, 1, 17);
  var d = Duration(hours: 3, minutes: 30);
  if (args.length > 1 &&
      DateTime.tryParse(args[0]) != null &&
      double.tryParse(args[1]) != null &&
      double.parse(args[1]) > 0) {
    //print('parsing args');
    t = DateTime.parse(args[0]);
    double h = double.parse(args[1]);
    d = Duration(
      hours: h ~/ 1,
      minutes: ((h % 1) * 60) ~/ 1,
      seconds: ((((h % 1) * 60) % 1) * 60).round(),
    );
  } else {
    print(
        'Please provide timestamp (i.e. "2022-08-01 10:30" or "2022-08-01 17:00") and duration in hours (i.e. 4 or 3.5) as arguments.\n\nExample:\n');
  }
  print(
      'Given timestamp $t and duration $d hours,\nthe next business date is ${bizDate(t, d).toString()}');
}

DateTime bizDate(DateTime t, Duration d) {
  int o = 0;
  if (t.weekday > DateTime.friday) {
    o = t.weekday - DateTime.monday;
  }
  if (t.weekday < DateTime.saturday) {
    var dur = t.difference(DateTime(t.year, t.month, t.day, 9));
    if (dur > Duration() && dur < Duration(hours: 9)) {
      d += dur;
    } else if (dur >= Duration(hours: 9)) {
      d += Duration(hours: 9);
    }
    d += Duration(hours: (t.weekday - 1) * 9);
  }
  int dWeeks = d.inHours ~/ 45;
  int dDays = (d.inHours % 45) ~/ 9;
  int dSeconds = (d.inSeconds % (45 * 60 * 60)) % (9 * 60 * 60);
  t = DateTime(t.year, t.month, t.day + o, 9);
  return t.add(Duration(days: 7 * dWeeks + dDays, seconds: dSeconds));
}
