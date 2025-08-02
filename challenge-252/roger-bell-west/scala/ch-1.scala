
object Specialnumbers {
  def specialnumbers(a: List[Int]): Int = {
    var t = 0
    for ((n, i) <- a.zipWithIndex) {
      if (a.length % (i + 1) == 0) {
        t += n * n
      }
    }
    return t
  }
  def main(args: Array[String]) {
      if (specialnumbers(List(1, 2, 3, 4)) == 21) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (specialnumbers(List(2, 7, 1, 19, 18, 3)) == 63) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
