
object Pythagorasmultiplied {
  def pythagorasmultiplied(n: Int): Int = {
    var ct = 0
    for (c <- 5 to n) {
      val csquared = c * c
      for (a <- 1 to c - 2) {
        val asquared = a * a
        for (b <- a + 1 to c - 1) {
          val bsquared = b * b
          val tot = asquared + bsquared
          if (tot == csquared) {
            ct += 1
          }
        }
      }
    }
    return ct * 2
  }
  def main(args: Array[String]) {
    if (pythagorasmultiplied(20) == 12) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(7) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(1) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(15) == 8) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(30) == 22) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
