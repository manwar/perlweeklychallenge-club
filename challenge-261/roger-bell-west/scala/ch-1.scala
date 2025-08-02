
object Elementdigitsum {
  def elementdigitsum(a: List[Int]): Int = {
    var delta = 0
    for (n0 <- a) {
      var n = n0 / 10
      var m = 10
      while (n > 0) {
        delta += (n % 10) * (m - 1)
        n /= 10
        m *= 10
      }
    }
    delta
  }
  def main(args: Array[String]) {
    if (elementdigitsum(List(1, 2, 3, 45)) == 36) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (elementdigitsum(List(1, 12, 3)) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (elementdigitsum(List(1, 2, 3, 4)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (elementdigitsum(List(236, 416, 336, 350)) == 1296) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
