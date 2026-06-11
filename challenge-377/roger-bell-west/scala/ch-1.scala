
object Reverseexistence {
  def reverseexistence(a: String): Boolean = {
    var ret = false
    val c = a.toList.reverse;
    for (d <- c.sliding(2)) {
      val sample = d(0).toString + d(1).toString
      if (a.contains(sample)) {
        ret = true
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (reverseexistence("abcba")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseexistence("racecar")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reverseexistence("abcd")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseexistence("banana")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseexistence("hello")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
