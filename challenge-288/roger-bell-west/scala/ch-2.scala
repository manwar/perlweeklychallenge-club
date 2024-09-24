import scala.collection.immutable.Queue
import scala.collection.mutable

object Contiguousblock {
  def contiguousblock(a: List[List[Char]]): Int = {
    val y = a.size
    val x = a(0).size
    var starts = mutable.Set.empty[List[Int]]
    for (cx <- 0 until x) {
      for (cy <- 0 until y) {
        starts += List(cx, cy)
      }
    }
    var maxblock = 0
    while (starts.size > 0) {
      val start = starts.toList(0)
      var queue = mutable.Queue.empty[List[Int]]
      var visited = mutable.Set.empty[List[Int]]
      visited += start
      queue += start
      while (queue.size > 0) {
        val here = queue.dequeue
        for (delta <- List(List(-1, 0), List(1, 0), List(0, -1), List(0, 1))) {
          if ((delta(0) >= 0 || here(0) > 0) &&
            (delta(0) <= 0 || here(0) < x - 1) &&
            (delta(1) >= 0 || here(1) > 0) &&
            (delta(1) <= 0 || here(1) < y - 1)) {
            val there = List(here(0) + delta(0), here(1) + delta(1))
            if (!visited.contains(there) &&
              a(there(1))(there(0)) == a(start(1))(start(0))) {
              visited += there
              queue += there
            }
          }
        }
      }
      val sz = visited.size
      if (sz > maxblock) {
        maxblock = sz
      }
      starts = starts.diff(visited)
    }
    return maxblock
  }
  def main(args: Array[String]) {
    if (contiguousblock(List(List('x', 'x', 'x', 'x', 'o'), List('x', 'o', 'o', 'o', 'o'), List('x', 'o', 'o', 'o', 'o'), List('x', 'x', 'x', 'o', 'o'))) == 11) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (contiguousblock(List(List('x', 'x', 'x', 'x', 'x'), List('x', 'o', 'o', 'o', 'o'), List('x', 'x', 'x', 'x', 'o'), List('x', 'o', 'o', 'o', 'o'))) == 11) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (contiguousblock(List(List('x', 'x', 'x', 'o', 'o'), List('o', 'o', 'o', 'x', 'x'), List('o', 'x', 'x', 'o', 'o'), List('o', 'o', 'o', 'x', 'x'))) == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
