
object Runningsum {
  def runningsum(a: List[Int]): List[Int] = {
    var b = a.toArray
    for (i <- 1 until a.length) {
      b(i) += b(i - 1)
    }
    return b.toList
  }
  def main(args: Array[String]) {
      if (runningsum(List(1, 2, 3, 4, 5)) == List(1, 3, 6, 10, 15)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (runningsum(List(1, 1, 1, 1, 1)) == List(1, 2, 3, 4, 5)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (runningsum(List(0, -1, 1, 2)) == List(0, -1, 0, 2)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
