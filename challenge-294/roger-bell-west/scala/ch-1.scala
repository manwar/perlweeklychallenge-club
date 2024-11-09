
object Consecutivesequence {
  def consecutivesequence(a: List[Int]): Int = {
    var b = a.sortWith(_ < _)
    var mxlen = 0
    var here = 0
    var oloop = true
    while (oloop) {
      var iloop = true
      for (there <- here + 1 until b.length) {
        if (iloop  && b(there) != (there - here) + b(here)) {
          val l = there - here
          if (l > mxlen) {
            mxlen = l
          }
          here = there
          iloop = false
        }
        if (iloop && there == b.length - 1) {
          val l = there - here + 1
          if (l > mxlen) {
            mxlen = l
          }
          here = there
          iloop = false
        }
      }
      if (here >= b.length - 1) {
        oloop = false
      }
    }
    if (mxlen < 2) {
      mxlen = -1
    }
    mxlen
  }
  def main(args: Array[String]) {
    if (consecutivesequence(List(10, 4, 20, 1, 3, 2)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (consecutivesequence(List(0, 6, 1, 8, 5, 2, 4, 3, 0, 7)) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (consecutivesequence(List(10, 30, 20)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
