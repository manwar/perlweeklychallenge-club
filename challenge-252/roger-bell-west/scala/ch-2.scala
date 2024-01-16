import scala.collection.mutable.ListBuffer

object Uniquesumzero {
  def uniquesumzero(n: Int): List[Int] = {
    if (n == 1) {
      return List(0)
    }
    var p = List.range(1, n).to[ListBuffer]
    p += -n * (n-1) / 2
    return p.toList
  }
  def main(args: Array[String]) {
      if (uniquesumzero(5) == List(1, 2, 3, 4, -10)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (uniquesumzero(3) == List(1, 2, -3)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (uniquesumzero(1) == List(0)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
