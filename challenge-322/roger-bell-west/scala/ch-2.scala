import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Rankarray {
  def rankarray(a: List[Int]): List[Int] = {
    val b =a.toSet.toList.sortWith(_ < _)
    var c = mutable.Map.empty[Int, Int]
    for ((n, i) <- b.zipWithIndex) {
      c += (n -> (i + 1))
    }
    var out = new ListBuffer[Int]
    for (v <- a) {
      out += c(v)
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (rankarray(List(55, 22, 44, 33)) == List(4, 1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rankarray(List(10, 10, 10)) == List(1, 1, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rankarray(List(5, 1, 1, 4, 3)) == List(4, 1, 1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
