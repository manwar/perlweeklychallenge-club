object DammCheckDigit extends App {
  var damm =
    Vector(
      Vector(0, 3, 1, 7, 5, 9, 8, 6, 4, 2),
      Vector(7, 0, 9, 2, 1, 5, 4, 8, 6, 3),
      Vector(4, 2, 0, 6, 8, 7, 1, 3, 5, 9),
      Vector(1, 7, 5, 0, 9, 8, 3, 4, 2, 6),
      Vector(6, 1, 2, 3, 0, 4, 5, 9, 7, 8),
      Vector(3, 6, 7, 4, 2, 0, 9, 5, 8, 1),
      Vector(5, 8, 6, 9, 7, 2, 0, 1, 3, 4),
      Vector(8, 9, 4, 5, 3, 6, 2, 0, 1, 7),
      Vector(9, 4, 3, 8, 6, 1, 7, 2, 0, 5),
      Vector(2, 5, 8, 1, 4, 3, 6, 7, 9, 0)
    )

  def is_valid(num: Int): Boolean = {
    val num_str = num.toString.getBytes
    var temp = 0
    for (ch <- num_str) {
      temp = damm(temp)(ch - '0')
    }
    return temp == 0
  }

  println("Valid numbers between 5700 and 5800 are:")
  for (i <- 5700 to 5800) {
    if (is_valid(i)) {
      printf("%d ", i)
    }
  }
  println("")
}
