import scala.collection.mutable.ListBuffer

object Minabsdiff {
  def minabsdiff(a: List[Int]): List[List[Int]] = {
    val b = a.sortWith(_ < _)
    var out = new ListBuffer[List[Int]]
    var mindiff = 1 + b(b.size - 1) - b(0)
    for (c <- b.sliding(2)) {
      val d = c(1) - c(0)
      if (d < mindiff) {
        out = new ListBuffer[List[Int]]
        mindiff = d
      }
      if (d == mindiff) {
        out += c.toList
      }
    }
    out.toList
  }

  def main(args: Array[String]) {
    if (minabsdiff(List(4, 2, 1, 3)) == List(List(1, 2), List(2, 3), List(3, 4))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minabsdiff(List(10, 100, 20, 30)) == List(List(10, 20), List(20, 30))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minabsdiff(List(-5, -2, 0, 3)) == List(List(-2, 0))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minabsdiff(List(8, 1, 15, 3)) == List(List(1, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minabsdiff(List(12, 5, 9, 1, 15)) == List(List(9, 12), List(12, 15))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
