import scala.collection.mutable

object Luckynumbers {
  def luckynumbers (a: List[List[Int]]): Int = {
    var maxs = mutable.Set.empty[List[Int]]
    for (x <- 0 to a(0).length - 1) {
      var max = List(0, 0, 0)
      for (y <- 0 to a.length - 1) {
        if (a(y)(x) > max(0)) {
          max = List(a(y)(x), y, x)
        }
      }
      maxs += max
    }
    var mins = mutable.Set.empty[List[Int]]
    for (y <- 0 to a.length - 1) {
      var min = List(a(y)(0), y, 0)
      for (x <- 0 to a(0).length - 1) {
        if (a(y)(x) < min(0)) {
          min = List(a(y)(x), y, x)
        }
      }
      mins += min
    }
    val i = (maxs & mins).toList
    if (i.length > 0) {
      return i(0)(0)
    }
    return -1
  }

  def main(args: Array[String]) {
    if (luckynumbers(List(List(3, 7, 9), List(9, 11, 13), List(15, 16, 17))) == 15) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (luckynumbers(List(List(1, 10, 4, 2), List(9, 3, 8, 7), List(15, 16, 17, 12))) == 12) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (luckynumbers(List(List(7, 8), List(1, 2))) == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
