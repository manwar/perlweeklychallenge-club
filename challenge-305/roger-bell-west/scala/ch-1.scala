import scala.collection.mutable.ListBuffer

object Binaryprefix {
  def isqrt(s: Int): Int = {
    if (s <= 1) {
      return s
    }
    var x0 = s / 2
    var x1 = (x0 + s / x0) / 2
    while (x1 < x0) {
      x0 = x1
      x1 = (x0 + s / x0) / 2
    }
    return x0
  }
  def is_prime(n: Int): Boolean = {
    var isprime = true
    if (n == 1) {
      isprime = false
    }
    if (n > 2 && n % 2 == 0) {
      isprime = false
    }
    if (n > 3 && n % 3 == 0) {
      isprime = false
    }
    if (isprime) {
      val lim = isqrt(n)
      var k6 = 0
      var cnt = true
      while (cnt) {
        k6 += 6
        for (t <- List(k6 - 1, k6 + 1)) {
          if (t <= lim) {
            if (n % t == 0) {
              isprime = false
              cnt = false
            }
          } else {
            cnt = false
          }
        }
      }
    }
    isprime
  }
  def binaryprefix(a: List[Int]): List[Boolean] = {
    var out = new ListBuffer[Boolean]
    var n = 0
    for (x <- a) {
      n *= 2
      if (x == 1) {
        n += 1
      }
      out += is_prime(n)
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (binaryprefix(List(1, 0, 1)) == List(false, true, true)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryprefix(List(1, 1, 0)) == List(false, true, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryprefix(List(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)) == List(false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
