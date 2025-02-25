import scala.collection.mutable

object Arraysintersection {
  def arraysintersection(a: List[List[Int]]): List[Int] = {
    var s = a(0).toSet
    for (b <- a.drop(1)) {
      s = s & b.toSet
    }
    s.toList.sortWith(_ < _)
  }
  def main(args: Array[String]) {
    if (arraysintersection(List(List(1, 2, 3, 4), List(4, 5, 6, 1), List(4, 2, 1, 3))) == List(1, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arraysintersection(List(List(1, 0, 2, 3), List(2, 4, 5))) == List(2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arraysintersection(List(List(1, 2, 3), List(4, 5), List(6))) == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
