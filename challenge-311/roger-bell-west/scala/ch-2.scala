
object Groupdigitsum {
  def groupdigitsum(a: String, sz: Int): String = {
    var s = a
    var n = 0
    var done = false
    while (!done) {
      var t = new String
      for ((c, i) <- s.zipWithIndex) {
        n += c.asDigit
        if (i == s.length - 1 || (i + 1) % sz == 0) {
          t += n.toString
          n = 0
        }
      }
      s = t
      if (s.length <= sz) {
        done = true
      }
    }
    s
  }
  def main(args: Array[String]) {
    if (groupdigitsum("111122333", 3) == "359") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupdigitsum("1222312", 2) == "76") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupdigitsum("100012121001", 4) == "162") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
