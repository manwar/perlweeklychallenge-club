import scala.collection.immutable.Queue
import scala.collection.mutable

object Shortestdistance {
  def shortestdistance(a: String, c: Char): List[Int] = {
    var q = mutable.Queue.empty[(Int, Int)]
    var i = 0
    while (i >= 0) {
      val p = a.indexOf(c, i)
      if (p >= 0) {
        q.enqueue((p, 0))
        i = p + 1
      } else {
        i = -1
      }
    }
    val invalid = a.length + 1
    var out = Array.fill(a.length)(invalid)
    while (q.size > 0) {
      val (i, v) = q.dequeue
      if (out(i) == invalid) {
        out(i) = v
        if (i > 0) {
          q.enqueue((i - 1, v + 1))
        }
        if (i < a.length - 1) {
          q.enqueue((i + 1, v + 1))
        }
      }
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (shortestdistance("loveleetcode", 'e') == List(3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shortestdistance("aaab", 'b') == List(3, 2, 1, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
