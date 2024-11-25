import scala.collection.mutable.ListBuffer

object Matchsticksquare {
  def matchsticksquare(a: List[Int]): Boolean = {
    val perimeter = a.sum
    var side = 0
    var sidesleft = 4
    var lengthleft = 0
    var ret = true
    if (perimeter % 4 != 0) {
      ret = false
    } else {
      side = perimeter / 4
      var ss = a.sortWith(_ > _)
      lengthleft = side
      var lp = true
      while (lp) {
        var leftover = new ListBuffer[Int]
        for (m <- ss) {
          if (m > side) {
            ret = false
            lp = false
          }
          if (m <= lengthleft) {
            lengthleft -= m
            if (lengthleft == 0) {
              sidesleft -= 1
              lengthleft = side
            }
          } else {
            leftover += m
          }
        }
        if (leftover.size == 0) {
          lp = false
        }
        ss = leftover.toList
      }
    }
    ret && sidesleft == 0 && lengthleft == side
  }
  def main(args: Array[String]) {
    if (matchsticksquare(List(1, 2, 2, 2, 1))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!matchsticksquare(List(2, 2, 2, 4))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!matchsticksquare(List(2, 2, 2, 2, 4))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (matchsticksquare(List(3, 4, 1, 4, 3, 1))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
