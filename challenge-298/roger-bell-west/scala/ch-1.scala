import scala.collection.mutable.ListBuffer

object Maximalsquare {
  def maximalsquare(a: List[List[Int]]): Int = {
    var mx = 0
    val boundy = a.size
    val boundx = a(0).size
    for (y <- 0 until  boundy) {
      for (x <- 0 until  boundx) {
        var size = 0
        var lp = true
        while (lp) {
          var tests = new ListBuffer[List[Int]]
          for (xx <- x to x + size) {
            tests += List(y + size, xx)
          }
          if (size > 0) {
            for (yy <- y to y + size - 1) {
              tests += List(yy, x + size)
            }
          }
          if (tests.map(x => a(x(0))(x(1))).exists(x => x == 0)) {
            lp = false
          } else {
            size += 1
            if (x + size >= boundx || y + size >= boundy) {
              lp = false
            }
          }
        }
        mx = List(mx, size * size).max
      }
    }
    return mx
  }
  def main(args: Array[String]) {
    if (maximalsquare(List(List(1, 0, 1, 0, 0), List(1, 0, 1, 1, 1), List(1, 1, 1, 1, 1), List(1, 0, 0, 1, 0))) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximalsquare(List(List(0, 1), List(1, 0))) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximalsquare(List(List(0))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
