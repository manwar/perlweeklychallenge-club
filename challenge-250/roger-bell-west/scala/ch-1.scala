
object Smallestindex {
  def smallestindex(a: List[Int]): Int = {
    for ((n, i) <- a.zipWithIndex) {
      if (n % 10 == i) {
        return i
      }
    }
    return -1
  }
  def main(args: Array[String]) {
      if (smallestindex(List(0, 1, 2)) == 0) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (smallestindex(List(4, 3, 2, 1)) == 2) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (smallestindex(List(1, 2, 3, 4, 5, 6, 7, 8, 9, 0)) == -1) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
