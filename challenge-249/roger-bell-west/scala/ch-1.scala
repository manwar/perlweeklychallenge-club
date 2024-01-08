import scala.collection.mutable.ListBuffer

object Shortestdistance {
  def shortestdistance(a0: List[Int]): List[List[Int]] = {
    if (a0.length % 2 != 0) {
      return List.empty
    }
    var a = a0.sortWith(_ < _)
    var out = new ListBuffer[List[Int]]
    for (t <- a.grouped(2)) {
      if (t(0) != t(1)) {
        return List.empty
      }
      out += List(t(0), t(0))
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (shortestdistance(List(3, 2, 3, 2, 2, 2)) == List(List(2, 2), List(2, 2), List(3, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shortestdistance(List(1, 2, 3, 4)) == List.empty) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
