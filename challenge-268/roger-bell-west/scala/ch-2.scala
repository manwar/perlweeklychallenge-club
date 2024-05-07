import scala.collection.mutable.ListBuffer

object Numbergame {
  def numbergame(a0: List[Int]): List[Int] = {
    var out = new ListBuffer[Int]
    val a = a0.sortWith(_ < _)
    for (s <- a.grouped(2)) {
      out += s(1)
      out += s(0)
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (numbergame(List(2, 5, 3, 4)) == List(3, 2, 5, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (numbergame(List(9, 4, 1, 3, 6, 4, 6, 1)) == List(1, 1, 4, 3, 6, 4, 9, 6)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (numbergame(List(1, 2, 2, 3)) == List(2, 1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
