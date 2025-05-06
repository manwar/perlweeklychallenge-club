
object Maximumcount {

  def maximumcount(a: List[Int]): Int = {
    var pos = 0
    var neg = 0
    for (n <- a) {
      if (n > 0) {
        pos += 1
      } else if (n < 0) {
        neg += 1
      }
    }
    List(pos, neg).max
  }

  def main(args: Array[String]) {
    if (maximumcount(List(-3, -2, -1, 1, 2, 3)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumcount(List(-2, -1, 0, 0, 1)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumcount(List(1, 2, 3, 4)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
