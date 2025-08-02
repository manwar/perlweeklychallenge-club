
object Countequaldivisible {
  def countequaldivisible(a: List[Int], k: Int): Int = {
    var s = 0
    for (i <- 0 to a.size - 2) {
      for (j <- i + 1 to a.size - 1) {
        if (a(i) == a(j) && i * j % k == 0) {
          s += 1
        }
      }
    }
    s
  }
  def main(args: Array[String]) {
    if (countequaldivisible(List(3, 1, 2, 2, 2, 1, 3), 2) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countequaldivisible(List(1, 2, 3), 1) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
