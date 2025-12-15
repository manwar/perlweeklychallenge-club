
object Arithmeticprogression {
  def arithmeticprogression(a0: List[Double]): Boolean = {
    val epsilon = 0.0001
    val a = a0.sortWith(_ < _)
    val delta = a(1) - a(0)
    var ret = true
    for (v <- a.drop(1).sliding(2)) {
      if (Math.abs(v(1) - v(0) - delta) > epsilon) {
        ret = false
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (arithmeticprogression(List(1, 3, 5, 7, 9))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arithmeticprogression(List(9, 1, 7, 5, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!arithmeticprogression(List(1, 2, 4, 8, 16))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arithmeticprogression(List(5, -1, 3, 1, -3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arithmeticprogression(List(1.5, 3, 0, 4.5, 6))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
