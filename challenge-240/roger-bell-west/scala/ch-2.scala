
object Buildarray {
  def buildarray(a: List[Int]): List[Int] = {
    return a.map(v => a(v)).toList
  }
  def main(args: Array[String]) {
      if (buildarray(List(0, 2, 1, 5, 3, 4)) == List(0, 1, 2, 4, 5, 3)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (buildarray(List(5, 0, 1, 2, 3, 4)) == List(4, 5, 0, 1, 2, 3)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
