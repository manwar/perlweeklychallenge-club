import scala.collection.mutable.ListBuffer

object Sortoddeven {
  def sortoddeven(a: List[Int]): List[Int] = {
    var odds = new ListBuffer[Int]
    var evens = new ListBuffer[Int]
    for ((x, i) <- a.zipWithIndex) {
      if (i % 2 == 0) {
        evens += x
      } else {
        odds += x
      }
    }
    evens = evens.sortWith(_ < _)
    odds = odds.sortWith(_ > _)
    var out = new ListBuffer[Int]
    for (i <- 0 until List(evens.size, odds.size).max) {
      if (i < evens.size) {
        out += evens(i)
      }
      if (i < odds.size) {
        out += odds(i)
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (sortoddeven(List(4, 1, 2, 3)) == List(2, 3, 4, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortoddeven(List(3, 1)) == List(3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortoddeven(List(5, 3, 2, 1, 4)) == List(2, 3, 4, 1, 5)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
