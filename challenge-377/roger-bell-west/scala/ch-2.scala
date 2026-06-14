
object Prefixsuffix {
  def prefixsuffix(a0: List[String]): Int = {
    var tot = 0
    val a = a0.sortWith(_.length < _.length)
    for (si <- 0.until(a.length - 1)) {
      for (li <- (si + 1).until(a.length)) {
        if (a(li).startsWith(a(si)) && a(li).endsWith(a(si))) {
          tot += 1
        }
      }
    }
    tot
  }
  def main(args: Array[String]) {
    if (prefixsuffix(List("a", "aba", "ababa", "aa")) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (prefixsuffix(List("pa", "papa", "ma", "mama")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (prefixsuffix(List("abao", "abab")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (prefixsuffix(List("abab", "abab")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (prefixsuffix(List("ab", "abab", "ababab")) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
