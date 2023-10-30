object Removeone {
  def removeone(a: List[Int]): Boolean = {
    var ec = 0
    var le = 1 + a(1) - a(0)
    for (s <- a.sliding(2)) {
      if (s(1) <= s(0)) {
        ec += 1
        if (ec > 1 || s(0) - s(1) >= le) {
          return false
        }
      }
      le = s(1) - s(0)
    }
    return true
  }

  def main(args: Array[String]) {
      if (removeone(List(0, 2, 9, 4, 6))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (!removeone(List(5, 1, 3, 2))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (removeone(List(2, 2, 3))) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
