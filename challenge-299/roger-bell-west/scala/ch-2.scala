import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Wordsearch {
  def encode(x: Int, y: Int): Int = {
    x * 64 + y
  }
  def decode(z: Int): List[Int] = {
    List(z / 64, z % 64)
  }
  def wordsearch(grid0: List[List[Char]], word0: String): Boolean = {
    var grid = mutable.Map.empty[Int, Char]
    for ((row, y) <- grid0.zipWithIndex) {
      for ((c, x) <- row.zipWithIndex) {
        grid += (encode(x, y) -> c)
      }
    }
    val word = word0.toList
    var ret = false
    for ((start, firstletter) <- grid) {
      if (!ret && firstletter == word(0)) {
        var queue = mutable.Queue.empty[List[Int]]
        queue += List(start)
        while (!ret && queue.size > 0) {
          val pos = queue.dequeue
          if (pos.size == word.size) {
            ret = true
          } else {
            for (dir <- List(List(0, 1), List(1, 0), List(0, -1), List(-1, 0))) {
              val lpos = decode(pos.last)
              val npos = List(lpos(0) + dir(0), lpos(1) + dir(1))
              val np = encode(npos(0), npos(1))
              if (grid.contains(np) &&
                !pos.contains(np) &&
                grid(np) == word(pos.size)) {
                var pp = pos.to[ListBuffer]
                pp += np
                queue += pp.toList
              }
            }
          }
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (wordsearch(List(List('A', 'B', 'D', 'E'), List('C', 'B', 'C', 'A'), List('B', 'A', 'A', 'D'), List('D', 'B', 'B', 'C')), "BDCA")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!wordsearch(List(List('A', 'A', 'B', 'B'), List('C', 'C', 'B', 'A'), List('C', 'A', 'A', 'A'), List('B', 'B', 'B', 'B')), "ABAC")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordsearch(List(List('B', 'A', 'B', 'A'), List('C', 'C', 'C', 'C'), List('A', 'B', 'A', 'B'), List('B', 'B', 'A', 'A')), "CCCAA")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
