import scala.collection.mutable

object Oddmatrix {
  def oddmatrix(rows: Int, cols: Int, points: List[List[Int]]): Int = {
    var rm = mutable.Set.empty[Int]
    var cm = mutable.Set.empty[Int]
    for (p <- points) {
      if (rm.contains(p(0))) {
        rm -= p(0)
      } else {
        rm += p(0)
      }
      if (cm.contains(p(1))) {
        cm -= p(1)
      } else {
        cm += p(1)
      }
    }
    rm.size * (cols - cm.size) +
    cm.size * (rows - rm.size)
  }
  def main(args: Array[String]) {
    if (oddmatrix(2, 3, List(List(0, 1), List(1, 1))) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddmatrix(2, 2, List(List(1, 1), List(0, 0))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddmatrix(3, 3, List(List(0, 0), List(1, 2), List(2, 1))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddmatrix(1, 5, List(List(0, 2), List(0, 4))) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddmatrix(4, 2, List(List(1, 0), List(3, 1), List(2, 0), List(0, 1))) == 8) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
