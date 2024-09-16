import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Relativesort {
  def relativesort(list1: List[Int], list2: List[Int]): List[Int] = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (p <- list1) {
      c += (p -> (c(p) + 1))
    }
    var out = new ListBuffer[Int]
    for (i <- list2) {
      out.appendAll(List.fill(c(i))(i))
      c.remove(i)
    }
    var d = c.keys.toList.sortWith(_ < _)
    for (i <- d) {
      out.appendAll(List.fill(c(i))(i))
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (relativesort(List(2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5), List(2, 1, 4, 3, 5, 6)) == List(2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (relativesort(List(3, 3, 4, 6, 2, 4, 2, 1, 3), List(1, 3, 2)) == List(1, 3, 3, 3, 2, 2, 4, 4, 6)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (relativesort(List(3, 0, 5, 0, 2, 1, 4, 1, 1), List(1, 0, 3, 2)) == List(1, 1, 1, 0, 0, 3, 2, 4, 5)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
