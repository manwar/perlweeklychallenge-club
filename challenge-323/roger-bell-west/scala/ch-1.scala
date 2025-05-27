
object Incrementdecrement {
  def incrementdecrement(operations: List[String]): Int = {
    var p = 0
    for (s <- operations) {
      if (s.charAt(1) == '+') {
        p += 1
      } else {
        p -= 1
      }
    }
    p
  }
  def main(args: Array[String]) {
    if (incrementdecrement(List("--x", "x++", "x++")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (incrementdecrement(List("x++", "++x", "x++")) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (incrementdecrement(List("x++", "++x", "--x", "x--")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
