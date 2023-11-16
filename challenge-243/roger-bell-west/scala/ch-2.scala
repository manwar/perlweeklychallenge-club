
object Floorsum {
  def floorsum(a: List[Int]): Int = {
    var n = 0
    for (iv <- a) {
      for (jv <- a) {
        n += iv / jv
      }
    }
    return n
  }
  def main(args: Array[String]) {
    if (floorsum(List(2, 5, 9)) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (floorsum(List(7, 7, 7, 7, 7, 7, 7)) == 49) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
