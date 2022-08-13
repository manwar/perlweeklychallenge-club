void main(List<String> args) {
  int y = args.isNotEmpty && int.tryParse(args[0]) != null
      ? int.parse(args[0])
      : 2019;
  print(LastWeekdayOfMonth(DateTime.friday, y));
}

class LastWeekdayOfMonth {
  final int weekday, year, month;
  final data = <DateTime>[];
  LastWeekdayOfMonth(this.weekday, this.year, [this.month = 0]) {
    final mdc = _monthdayCount(year);
    for (var i = 0; i < mdc.length; i++) {
      var t = DateTime.utc(year, i + 1, mdc[i]);
      var o = weekday - t.weekday;
      data.add(t.add(Duration(days: o > 0 ? o - 7 : o)));
    }
  }
  List<int> _monthdayCount(int year) =>
      [31, year % 4 == 0 ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  @override
  String toString() =>
      [if (month == 0) ...data, if (month > 0 && month <= 12) data[month - 1]]
          .map(
              (dt) => dt.toString().split(" ")[0].replaceAll(RegExp(r'-'), '/'))
          .join("\n");
}
