object Ethiopian extends App {
  mult(15, 24)

  def mult(a: Int, b: Int): Unit = {
    var (i, j) = (a, b)
    var sum = if (i % 2 != 0) j else 0
    while (i > 1) {
      i /= 2;
      j *= 2;
      if (i % 2 != 0) {
        sum += j
      }
    }
    println(s"product of $a and $b is: $sum")

  }
}
// Prints: product of 15 and 24 is: 360
