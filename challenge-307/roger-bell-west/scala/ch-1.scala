import scala.collection.mutable.ListBuffer

object Checkorder {
  def checkorder(a: List[Int]): List[Int] = {
    var b = a.sortWith(_ < _)
    var out = new ListBuffer[Int]
    for ((c, i) <- a.zipWithIndex) {
      if (b(i) != c) {
        out += i
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (checkorder(List(5, 2, 4, 3, 1)) == List(0, 2, 3, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (checkorder(List(1, 2, 1, 1, 3)) == List(1, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (checkorder(List(3, 1, 3, 2, 3)) == List(0, 1, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
