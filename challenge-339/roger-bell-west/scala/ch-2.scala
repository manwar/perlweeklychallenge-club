
object Peakpoint {
  def peakpoint(a: List[Int]): Int = {
    var h = 0
    var o = 0
    for (p <- a) {
      h += p
      o = List(o, h).max
    }
    o
  }
  def main(args: Array[String]) {
    if (peakpoint(List(-5, 1, 5, -9, 2)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpoint(List(10, 10, 10, -25)) == 30) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpoint(List(3, -4, 2, 5, -6, 1)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpoint(List(-1, -2, -3, -4)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpoint(List(-10, 15, 5)) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
