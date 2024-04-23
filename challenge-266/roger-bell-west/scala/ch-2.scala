
object Xmatrix {
  def xmatrix(a: List[List[Int]]): Boolean = {
    val order = a.size - 1
    var valid = true
    for ((row, y) <- a.zipWithIndex) {
      for ((value, x) <- row.zipWithIndex) {
        if (x == y || x == order - y) {
          if (value == 0) {
            valid = false;
          }
        } else {
          if (value != 0) {
            valid = false;
          }
        }
      }
    }
    valid
  }

  def main(args: Array[String]) {
    if (xmatrix(List(List(1, 0, 0, 2), List(0, 3, 4, 0), List(0, 5, 6, 0), List(7, 0, 0, 1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!xmatrix(List(List(1, 2, 3), List(4, 5, 6), List(7, 8, 9)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (xmatrix(List(List(1, 0, 2), List(0, 3, 0), List(4, 0, 5)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
