
object Goodinteger {
  def goodinteger(a: Int): Int = {
    val winsize = 3
    val d = a.toString.split("")
    var ex = -1
    for ((cc, offset) <- d.sliding(winsize).zipWithIndex) {
      if (ex == -1 && cc(0) == cc(1) && cc(1) == cc(2)) {
        if ((offset == 0 || d(offset- 1) != cc(0)) &&
          (offset == d.size - winsize || d(offset + winsize) != cc(2))) {
          ex = cc.mkString("").toInt
        }
      }
    }
    ex
  }
  def main(args: Array[String]) {
    if (goodinteger(12344456) == 444) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goodinteger(1233334) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goodinteger(10020003) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
