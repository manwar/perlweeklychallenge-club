import scala.collection.mutable.ListBuffer

object Kaprekarconstant {
  def a2n(a: ListBuffer[Int]): Int = {
    var t = 0
    for (d <- a) {
      t *= 10
      t += d
    }
    t
  }

  def kaprekarconstant(a: Int): Int = {
    var ct = 0
    var b = a
    while (b != 6174 && ct != -1) {
      if (b == 0) {
        ct = -1
      } else {
        var digits = new ListBuffer[Int]
        for (i <- 0 to 3) {
          digits += b % 10
          b /= 10
        }
        digits = digits.sortWith(_ < _)
        val stigid = digits.reverse
        b = a2n(stigid) - a2n(digits)
        ct += 1
      }
    }
    ct
  }

  def main(args: Array[String]) {
    if (kaprekarconstant(3524) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (kaprekarconstant(6174) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (kaprekarconstant(9998) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (kaprekarconstant(1001) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (kaprekarconstant(9000) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (kaprekarconstant(1111) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
