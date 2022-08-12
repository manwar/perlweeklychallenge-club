void main() {
  int startY = 2019;
  int endY = 2100;
  for (var y = startY; y <= endY; y++) {
    var t = DateTime(y, 12, 25);
    if (t.weekday == DateTime.sunday) {
      print(t);
    }
  }
}
