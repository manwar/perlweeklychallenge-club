
object Maxdistance {
  def maxdistance(a: List[Int], b: List[Int]): Int = {
    val l1 = a.min
    val h1 = a.max
    val l2 = b.min
    val h2 = b.max
    List(h1 - l2, h2 - l1).max
  }
  def main(args: Array[String]) {
    if (maxdistance(List(4, 5, 7), List(9, 1, 3, 4)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdistance(List(2, 3, 5, 4), List(3, 2, 5, 5, 8, 7)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdistance(List(2, 1, 11, 3), List(2, 5, 10, 2)) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdistance(List(1, 2, 3), List(3, 2, 1)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdistance(List(1, 0, 2, 3), List(5, 0)) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
