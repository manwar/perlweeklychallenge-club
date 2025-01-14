
object Arrangebinary {
  def arrangebinary(a: List[Int], n: Int): Boolean = {
    var b = a.toArray
    var t = n
    for (i <- 0 until b.length) {
      if (b(i) == 0 &&
        (i == 0 || b(i - 1) == 0) &&
        (i == b.length - 1 || b(i + 1) == 0)) {
        b(i) = 1
        t -= 1
      }
    }
    t <= 0
  }
  def main(args: Array[String]) {
    if (arrangebinary(List(1, 0, 0, 0, 1), 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!arrangebinary(List(1, 0, 0, 0, 1), 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
