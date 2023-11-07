
object Missingmembers {
  def halfmissing(a: List[Int], bh: Set[Int]): List[Int] = {
    return a.filter(n => !bh.contains(n)).distinct
  }
  def missingmembers(a: List[Int], b: List[Int]): List[List[Int]] = {
    val ah = a.toSet
    val bh = b.toSet
    return List(halfmissing(a, bh), halfmissing(b, ah))
  }
  def main(args: Array[String]) {
      if (missingmembers(List(1, 2, 3), List(2, 4, 6)) == List(List(1, 3), List(4, 6))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (missingmembers(List(1, 2, 3, 3), List(1, 1, 2, 2)) == List(List(3), List())) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
