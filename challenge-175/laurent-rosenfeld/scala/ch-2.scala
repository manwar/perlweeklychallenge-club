object PerfectTotient extends App {

  var cache = new Array[Int](10000)

  def gcd(a: Int, b: Int): Int = {
    var (i, j) = (a, b)
    while (j > 0) {
      var t = i
      i = j
      j = t % j
    }
    return i
  }

  def is_perfect_totient(n: Int): Boolean = {
    var tot = 0
    for (i <- 1 to (n - 1)) {
      if (gcd(n, i) == 1) {
        tot += 1
      }
    }
    val sum = tot + cache(tot)
    cache(n) = sum
    return n == sum
  }

  var i = 1
  var count = 0
  while (count < 20) {
    if (is_perfect_totient(i)) {
      count += 1
      printf("%d ", i)
    }
    i += 1
  }
  println("")
}
