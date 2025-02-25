import scala.collection.mutable.ListBuffer

object Boomerang {
  def boomerang(a: List[List[Int]]): Boolean = {
    var ret = false
    var done = false
    var delta = new ListBuffer[List[Int]]
    // coincident points
    for (ij <- 0 to 1) {
      for (ik <- ij + 1 to 2) {
        if (a(ij)(0) == a(ik)(0) && a(ij)(1) == a(ik)(1)) {
          ret = false
          done = true
        }
      }
      delta += List(a(ij + 1)(0) - a(0)(0), a(ij + 1)(1) - a(0)(1))
    }
    // all on the same vertical line
    if (!done) {
      if (delta(0)(0) == 0 && delta(1)(0) == 0) {
        ret = false
        done = true
      }
    }
    // just one vertical line
    if (!done) {
      if (delta(0)(0) == 0 || delta(1)(0) == 0) {
        ret = true
        done = true
      }
    }
    if (!done) {
      val m = delta(0)(1).toFloat / delta(0)(0).toFloat
      val c = a(0)(1).toFloat - a(0)(0).toFloat * m
      ret = a(2)(1).toFloat != a(2)(0).toFloat * m + c
    }
    return ret
  }
  def main(args: Array[String]) {
    if (boomerang(List(List(1, 1), List(2, 3), List(3, 2)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!boomerang(List(List(1, 1), List(2, 2), List(3, 3)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (boomerang(List(List(1, 1), List(1, 2), List(2, 3)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!boomerang(List(List(1, 1), List(1, 2), List(1, 3)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!boomerang(List(List(1, 1), List(2, 1), List(3, 1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (boomerang(List(List(0, 0), List(2, 3), List(4, 5)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
