void main(List<String> args) {
  int year = args.isNotEmpty && int.tryParse(args[0]) != null
      ? int.parse(args[0])
      : 2021;
  int workdays =
      52 * 5; // non-leap year has 52 weeks which yeilds 52 * 5 workdays
  int daysLeft =
      1; // day(s) left from 52 weeks to check for a workday is 365 - ( 52 * 7 ) = 1
  if (year % 4 == 0) {
    daysLeft++; // leap year will have another day
  }
  // find another workday in daysLeft
  var t = DateTime(year, DateTime.december, 31);
  for (int d = 0; d < daysLeft; d++) {
    if (t.subtract(Duration(days: d)).weekday < DateTime.saturday) {
      workdays++;
    }
  }
  print('Input: year = $year\nOutput: $workdays');
}
