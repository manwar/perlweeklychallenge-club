object root extends App {
  def isUgly(in: Int): Boolean = {
    var cpy = in
    val div = List(2, 3, 5);
    for (i <- div) {
      while (cpy % i == 0) {
        cpy = cpy / i
      }
    }
    if (cpy == 1) { return true }
    return false
  }
  val n = 7
  var j = 0
  var k = 0
  while (k <= n) {
    j = j + 1
    if (isUgly(j)) {
      k = k + 1
      // println(k)
      if (k == n) { println(k) }
    }
  }
}
