import scala.collection.mutable

object Largestinterval {
  def hasrepeateddigits(a: Int): Boolean = {
    var cs = mutable.Set.empty[Char]
    var rep = false
    for (c <- a.toString.toList) {
      if (cs.contains(c)) {
        rep = true
      } else {
        cs += c
      }
    }
    rep
  }
  def largestinterval(a: Int): Int = {
    val v = (1 to a).filter(x => !hasrepeateddigits(x))
    v.sliding(2).map(x => x(1) - x(0)).max
  }
  def main(args: Array[String]) {
    if (largestinterval(20) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestinterval(110) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestinterval(500) == 11) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestinterval(2026) == 105) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestinterval(10000) == 105) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
