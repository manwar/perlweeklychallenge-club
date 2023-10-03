
object Maximisegreatness {
  def maximisegreatness(a: List[Int]): Int = {
    val b = a.sortWith(_ < _)
    var g = 0
    for (c <- b) {
      if (c > b(g)) {
        g += 1
      }
    }
    return g
  }

  def main(args: Array[String]) {
      if (maximisegreatness(List(1, 3, 5, 2, 1, 3, 1)) == 4) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (maximisegreatness(List(1, 2, 3, 4)) == 3) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
