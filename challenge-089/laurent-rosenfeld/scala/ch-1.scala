object Main {
  def main(args: Array[String]): Unit = {
    val in: Int = if (args.size == 1) args(0).toInt else 10
    var sum = 0
    for (m <- 1 to in) {
      for (n <- m + 1 to in) {
        sum += gcd(m, n)
      }
    }
    println(s"Sum of GCD to $in is $sum")
  }
  def gcd(a: Int, b: Int): Int = {
    var (i, j) = (a, b)
    while (j > 0) {
      var t = i
      i = j
      j = t % j
    }
    return i
  }
}
