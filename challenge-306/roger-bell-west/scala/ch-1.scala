
object Oddsum {
  def oddsum(a: List[Int]): Int = {
    var out = a.sum
    var l = 3
    while (l <= a.size) {
      for (s <- a.sliding(l)) {
        out += s.sum
      }
      l += 2
    }
    out
  }
  def main(args: Array[String]) {
    if (oddsum(List(2, 5, 3, 6, 4)) == 77) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddsum(List(1, 3)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
