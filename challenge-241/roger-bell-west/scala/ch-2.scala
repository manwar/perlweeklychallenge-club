import scala.collection.mutable

object Primeorder {
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
  def genprimes(mx: Int): List[Int] = {
    var primesh = mutable.Set.empty[Int]
    for (i <- 2 until 4) {
      primesh += i
    }
    for (i <- 6 until(mx + 2, 6)) {
      for (j <- i-1 until(i+2, 2)) {
        if (j <= mx) {
          primesh += j
        }
      }
    }
    var q = mutable.Queue[Int](2, 3, 5, 7)
    var p = q.dequeue
    val mr = isqrt(mx)
    while (p <= mr) {
      if (primesh.contains(p)) {
        for (i <- p*p until (mx + 1, p)) {
          primesh -= i
        }
      }
      if (q.length < 2) {
        q += (q.last + 4)
        q += (q.last + 2)
      }
      p = q.dequeue
    }
    return primesh.toList.sortWith(_ < _)
  }
  def primefactor(n: Int): mutable.Map[Int, Int] = {
    var f = mutable.Map.empty[Int, Int]
    var m = n
    for (p <- genprimes(isqrt(m))) {
      while (m % p == 0 && m > 1) {
        m /= p
        var nv = 1
        if (f.contains(p)) {
          nv = f(p) + 1
        }
        f += (p -> nv)
      }
    }
    if (m > 1) {
      var nv = 1
      if (f.contains(m)) {
        nv = f(m) + 1
      }
      f += (m -> nv)
    }
    return f
  }
  def primefactorcount(n: Int): Int = {
    return primefactor(n).values.sum
  }
  def primeorder(a: List[Int]): List[Int] = {
    val c = a.map(n => n -> primefactorcount(n)).toMap
    var b = a.toArray
    b = b.sortWith((aa, bb) => {
      if (c(aa) == c(bb)) {
        aa < bb
      } else {
        c(aa) < c(bb)
      }
    })
    return b.toList
  }
  def main(args: Array[String]) {
    if (primeorder(List(11, 8, 27, 4)) == List(11, 4, 8, 27)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
