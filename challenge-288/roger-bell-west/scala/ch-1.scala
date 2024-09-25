
object Closestpalindrome {
  def closestpalindrome(a: String): String = {
    val n = a.toInt
    var delta = -1
    while (true) {
      val q = (n + delta).toString
      if (q == q.reverse) {
        return q
      }
      delta = -delta;
      if (delta < 0) {
        delta -= 1
      }
    }
    return ""
  }
  def main(args: Array[String]) {
    if (closestpalindrome("123") == "121") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (closestpalindrome("2") == "1") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (closestpalindrome("1400") == "1441") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (closestpalindrome("1000") == "999") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
