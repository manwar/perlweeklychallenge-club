
object Mingap {
  def mingap(a: List[Int]): Int = {
    var mg = a(a.size - 1) - a(0)
    var mv = 0
    for (p <- a.sliding(2)) {
      val delta = p(1) - p(0)
      if (delta < mg) {
        mg = delta
        mv = p(1)
      }
    }
    mv
  }
  def main(args: Array[String]) {
    if (mingap(List(2, 8, 10, 11, 15)) == 11) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (mingap(List(1, 5, 6, 7, 14)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (mingap(List(8, 20, 25, 28)) == 28) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
