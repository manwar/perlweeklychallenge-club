import scala.collection.mutable

object Primestep {
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
  def primestep(a: String): Int = {
    val g: Int = a.toList.map(c => c.toInt).sum
    val pm = genprimes(g * 2)
    val lo = pm.filter(x => x <= g).last
    val hi = pm.filter(x => x > g)(0)
    List(g - lo, hi - g).min
  }
  def main(args: Array[String]) {
    if (primestep("hello") == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (primestep("football") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (primestep("a") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (primestep("challenge") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (primestep("perl") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
