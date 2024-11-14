import scala.collection.mutable

object Jumpgame {
  def jumpgame(a: List[Int]): Int = {
    val target = a.size - 1
    var here = mutable.Set.empty[Int]
    here += 0
    var moves = 0
    var lp = true
    var ret = 0
    while (lp) {
      moves += 1
      var there = mutable.Set.empty[Int]
      for (n <- here) {
        for (i <- n + 1 to List(n + a(n), target).min) {
          there += i
        }
        if (there.isEmpty) {
          ret = -1
          lp = false
        }
        if (there.contains(target)) {
          ret = moves
          lp = false
        }
        here = there
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (jumpgame(List(2, 3, 1, 1, 4)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (jumpgame(List(2, 3, 0, 4)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (jumpgame(List(2, 0, 0, 4)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
