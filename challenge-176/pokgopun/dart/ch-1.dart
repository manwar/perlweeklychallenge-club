void main() {
  var count = 1;
  for (var i = 3; i < 10; i++) {
    for (var cmb in combo(i, "0123456789", "", <String>[])) {
      var min = int.parse(cmb);
      var max = int.parse(cmb.split("").reversed.join(""));
      if (max ~/ min < 6) {
        continue;
      }
      //print("$cmb => " + max.toString());
      final permutes = <String>[];
      for (var pmt in permute(cmb, "", permutes)) {
        var j = 0;
        for (j = 6; j > 1; j--) {
          if (!permutes.contains((j * int.parse(pmt)).toString())) {
            break;
          }
        }
        if (j == 1) {
          print(pmt);
          count--;
          break;
        }
      }
      if (count == 0) {
        break;
      }
    }
    if (count == 0) {
      break;
    }
  }
}

List<String> permute(String s, String t, List<String> res) {
  if (s.length > 0) {
    for (var i = 0; i < s.length; i++) {
      permute(s.replaceRange(i, i + 1, ""), t + s[i], res);
    }
  } else {
    res.add(t);
  }
  return res;
}

List<String> combo(int r, String e, String c, List<String> res) {
  if (c.length == r || c.length + e.length == r) {
    res.add((c + e).substring(0, r));
  } else {
    for (var i = 0; i <= c.length + e.length - r; i++) {
      combo(r, e.substring(i + 1), c + e.substring(i, i + 1), res);
    }
  }
  return res;
}
