
object Nearestvalidpoint {
  def nearestvalidpoint(x: Int, y: Int, points: List[List[Int]]): Int = {
    var ix = -1;
    var minmhd = -1;
    for ((p, i) <- points.zipWithIndex) {
      if (p(0) == x || p(1) == y) {
        val mhd = (p(0) - x).abs + (p(1) - y).abs
        if (minmhd == -1 || mhd < minmhd) {
          minmhd = mhd
          ix = i
        }
      }
    }
    ix
  }
  def main(args: Array[String]) {
    if (nearestvalidpoint(3, 4, List(List(1, 2), List(3, 1), List(2, 4), List(2, 3))) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(2, 5, List(List(3, 4), List(2, 3), List(1, 5), List(2, 5))) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(1, 1, List(List(2, 2), List(3, 3), List(4, 4))) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(0, 0, List(List(0, 1), List(1, 0), List(0, 2), List(2, 0))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(5, 5, List(List(5, 6), List(6, 5), List(5, 4), List(4, 5))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
