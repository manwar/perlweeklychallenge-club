import scala.collection.mutable

object Smallerthancurrent {
  def smallerthancurrent(a: List[Int]): List[Int] = {
    val s: List[Int] = a.sortWith(_ < _)
    var l = mutable.Map.empty[Int, Int]
    for ((n, i) <- s.zipWithIndex) {
      if (!l.contains(n)) {
        l += (n -> i)
      }
    }
    a.map { n => l(n) }.toList
  }
  def main(args: Array[String]) {
    if (smallerthancurrent(List(5, 2, 1, 6)) == List(2, 1, 0, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(1, 2, 0, 3)) == List(1, 2, 0, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(0, 1)) == List(0, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(9, 4, 9, 2)) == List(2, 1, 2, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
