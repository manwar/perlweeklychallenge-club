import scala.collection.immutable.Queue
import scala.collection.mutable

object Knightsmove {

  def cs2xy(a: String): List[Int] = {
    val c = a.toList
    val x = c(0).toInt - 'a'.toInt
    val y = c(1).toInt - '1'.toInt
    return List(x, y)
  }

  def knightsmove(from: String, to: String): Int = {
    val fc = cs2xy(from)
    val tc = cs2xy(to)
    var queue = mutable.Queue.empty[List[Int]]
    queue += List(fc(0), fc(1), 0)
    var seen = mutable.Set.empty[Int]
    var result = -1
    while (queue.size > 0) {
      val cc = queue.dequeue
      if (cc(0) == tc(0) && cc(1) == tc(1)) {
        result = cc(2)
        queue = mutable.Queue.empty[List[Int]]
      } else {
        for (offset <- List(
          List(2, 1),
          List(1, 2),
          List(2, -1),
          List(1, -2),
          List(-2, 1),
          List(-1, 2),
          List(-2, -1),
          List(-1, -2)
        )) {
          val x = cc(0) + offset(0)
          val y = cc(1) + offset(1)
          if (x >= 0 && x <= 7 && y >= 0 && y <= 7) {
            val cv = x * 8 + y
            if (!seen.contains(cv)) {
              queue += List(x, y, cc(2) + 1)
              seen += (cv)
            }
          }
        }
      }
    }
    return result
  }

  def main(args: Array[String]) {
    if (knightsmove("g2", "a8") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (knightsmove("g2", "h2") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
