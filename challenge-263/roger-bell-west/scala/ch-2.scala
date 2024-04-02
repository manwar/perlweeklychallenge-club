import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Mergeitems {
  def mergeitems(a: List[List[Int]], b: List[List[Int]]): List[List[Int]] = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (v <- List(a, b)) {
      for (w <- v) {
        c += (w(0) -> (c(w(0)) + w(1)))
      }
    }
    var k = c.keys.toList.sortWith(_ < _)
    k.map(i => List(i, c(i))).toList
  }
  def main(args: Array[String]) {
      if (mergeitems(List(List(1, 1), List(2, 1), List(3, 2)), List(List(2, 2), List(1, 3))) == List(List(1, 4), List(2, 3), List(3, 2))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (mergeitems(List(List(1, 2), List(2, 3), List(1, 3), List(3, 2)), List(List(3, 1), List(1, 3))) == List(List(1, 8), List(2, 3), List(3, 3))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (mergeitems(List(List(1, 1), List(2, 2), List(3, 3)), List(List(2, 3), List(2, 4))) == List(List(1, 1), List(2, 9), List(3, 3))) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
