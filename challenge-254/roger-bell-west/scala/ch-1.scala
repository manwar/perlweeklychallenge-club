
object Threepower {
  def threepower(n0: Int): Boolean = {
    if (n0 == 0) {
      return false
    }
    var n = n0.abs
    var lo = 1
    var hi = n / 2
    while (true) {
      val t = (lo + hi) / 2
      val c = t * t * t
      if (c == n) {
        return true
      }
      if (lo == t) {
        return false
      }
      if (c < n) {
        lo = t
      } else {
        hi = t
      }
    }
    return false
  }
  def main(args: Array[String]) {
    if (threepower(27)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!threepower(0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!threepower(6)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
