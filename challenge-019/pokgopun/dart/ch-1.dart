final monthsWith31Days = const {
  DateTime.january: 'January',
  DateTime.march: 'March',
  DateTime.may: 'May',
  DateTime.july: 'July',
  DateTime.august: 'August',
  DateTime.october: 'October',
  DateTime.december: 'December',
};
void main() {
  int startY = 1900;
  int endY = 2019;
  for (var y = startY; y <= endY; y++) {
    print("$y: ${monthsWith31Days.keys // use key which is month number to build DateTime
        .where((m) => DateTime(y, m, 1).weekday == DateTime.friday) // filter in only when 1st of the month is friday
        .map((m) => monthsWith31Days[m]) // map month number to month label
        .join(", ")}");
  }
}
