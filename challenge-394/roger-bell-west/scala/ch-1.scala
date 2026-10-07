import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Alternatecase {
  def alternatecase(a: String): Int = {
    val uppers = a.toList.map(c => c.isUpper).toList
    var queue = mutable.Queue.empty[Tuple2[List[Boolean], Int]]
    queue += Tuple2(uppers, 0)
    var ex = 0
    while (queue.size > 0) {
      val (up, ct) = queue.dequeue
      var swaps = new ListBuffer[Int]
      for (i <- 0 until up.size - 1) {
        if (up(i) == up(i + 1)) {
          if (i > 0) {
            swaps += (i - 1)
          }
          if (i < up.size - 2) {
            swaps += (i + 1)
          }
        }
      }
      if (swaps.size == 0) {
        ex = ct
        queue.clear
      } else {
        for (sw <- swaps) {
          var uq = up.to[ListBuffer]
          val tmp = uq(sw)
          uq(sw) = uq(sw + 1)
          uq(sw + 1) = tmp
          queue += Tuple2(uq.toList, ct + 1)
        }
      }
    }
    ex
  }
  def main(args: Array[String]) {
    if (alternatecase("aAbB") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatecase("AAbb") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatecase("AAAbbb") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatecase("aABb") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatecase("bBBAaa") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
