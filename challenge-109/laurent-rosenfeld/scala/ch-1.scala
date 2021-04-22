object chowla extends App {
  def chowla(n: Int): Int = {
    if (n <= 2) return 0
    var sum = 0;
    for (i <- 2 until n/2 + 1) {
      if (n % i == 0) sum += i
    }
    return sum
  }
  println((1 until 21).map(chowla(_)).mkString(", "))
}
