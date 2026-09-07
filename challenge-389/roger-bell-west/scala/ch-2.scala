
object Zigzagsubarray {
  def zigzagsubarray(a: List[Int]): Int = {
    var mx = List(1, a.size).min
    for (i <- 0 to a.size - 1) {
      var o = 0
      var lastdir = 0
      var cnt = true
      var thisdir = 0
      for (j <- i to a.size - 1) {
        if (cnt) {
          thisdir = 0
          if (j > i) {
            if (a(j) > o) {
              thisdir = 1
              mx = List(mx, 2).max
            } else if (a(j) < o) {
              thisdir = -1
              mx = List(mx, 2).max
            }
          }
          if ((j > i && thisdir == 0) || (j > i + 1 && thisdir * lastdir != -1)) {
            cnt = false
          }
        }
        if (cnt) {
          o = a(j)
          lastdir = thisdir
          mx = List(mx, j - i + 1).max
        }
      }
    }
    mx
  }

  def main(args: Array[String]) {
    if (zigzagsubarray(List(9, 4, 2, 10, 7, 8, 8, 1, 9)) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zigzagsubarray(List(1, 7, 4, 9, 2, 5)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zigzagsubarray(List(1, 2, 3, 4, 5)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zigzagsubarray(List(4, 4, 4)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zigzagsubarray(List(10, 20, 15, 12, 18)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
