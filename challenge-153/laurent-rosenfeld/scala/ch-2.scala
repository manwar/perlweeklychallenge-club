object factorion extends App {
  def is_factorion(fact: Array[Int], num: Int): Boolean = {
    var sum = 0
    var i = num
    while (i > 0) {
      sum += fact(i % 10)
      i /= 10
    }
    return num == sum
  }

  val fact = new Array[Int](12)
  fact(0) = 1
  for (n <- 1 to 9) {
    fact(n) = n * fact(n - 1)
  }

  for (j <- 1 to 50000) {
    if (is_factorion(fact, j)) {
      println(j)
    }
  }
}
