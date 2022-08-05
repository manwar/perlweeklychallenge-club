object reversible extends App {
  def is_reversible(n: Int): Boolean = {
    var sum = n + n.toString.reverse.toInt
    while (sum > 0) {
      val k = sum % 10
      if (k % 2 == 0) {
        return false
      }
      sum /= 10
    }
    return true
  }

  for (i <- 1 to 100) {
    if (is_reversible(i)) {
      printf("%d ", i)
    }
  }
  println("")
}
