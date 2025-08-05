
object Straightline {
  def straightline(a: List[List[Double]]): Boolean = {
    var ret = true
    val b = a.distinct
    if (b.size > 2) {
      val p = b(0)(0)
      val q = b(1)(0) - b(0)(0)
      val r = b(0)(1)
      val s = b(1)(1) - b(0)(1)
      for (tpair <- b.drop(2)) {
        if (ret) {
          if (q == 0.0 && tpair(0) != b(0)(0)) {
            ret = false
          }
          if (s == 0.0 && tpair(1) != b(0)(1)) {
            ret = false
          }
          if (q != 0.0 && s != 0.0) {
            val n1 = (tpair(0) - p ) / q
            val n2 = (tpair(1) - r ) / s
            if (n1 != n2) {
              ret = false
            }
          }
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (straightline(List(List(2, 1), List(2, 3), List(2, 5)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (straightline(List(List(1, 4), List(3, 4), List(10, 4)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!straightline(List(List(0, 0), List(1, 1), List(2, 3)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (straightline(List(List(1, 1), List(1, 1), List(1, 1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
