import scala.collection.mutable.ListBuffer

object Spellboundsorting {
  def spellboundsorting(a: List[Int]): List[Int] = {
    a.sortBy(towords(_))
  }
  def towords(a: Int): String = {
    if (a == 0) {
      "zero"
    } else {
      var components = new ListBuffer[String]
      var b = a
      if (a < 0) {
        b = -a
        components += "minus"
      }
      val vw = List(
        (1000000000, "milliard"),
        (1000000, "million"),
        (1000, "thousand"),
        (100, "hundred"),
        (90, "ninety"),
        (80, "eighty"),
        (70, "seventy"),
        (60, "sixty"),
        (50, "fifty"),
        (40, "forty"),
        (30, "thirty"),
        (20, "twenty"),
        (19, "nineteen"),
        (18, "eighteen"),
        (17, "seventeen"),
        (16, "sixteen"),
        (15, "fifteen"),
        (14, "fourteen"),
        (13, "thirteen"),
        (12, "twelve"),
        (11, "eleven"),
        (10, "ten"),
        (9, "nine"),
        (8, "eight"),
        (7, "seven"),
        (6, "six"),
        (5, "five"),
        (4, "four"),
        (3, "three"),
        (2, "two"),
        (1, "one")
      )
      for (w <- cw(b, vw)) {
        components += w
      }
      components.mkString(" ")
    }
  }
  def cw(n: Int, vw: List[Tuple2[Int, String]]): List[String] = {
    var res = new ListBuffer[String]
    var latch = false
    for ((vl, word) <- vw) {
      if (!latch && n >= vl) {
        latch = true
        var andflag = false
        if (n >= 100) {
          andflag = true
          for (w <- cw(n / vl, vw)) {
            res += w
          }
        }
        res += word
        val p = n % vl
        if (p > 0) {
          if (andflag) {
            res += "and"
          }
          for (w <- cw(p, vw)) {
            res += w
          }
        }
      }
    }
    res.toList
  }
  def main(args: Array[String]) {
    if (spellboundsorting(List(6, 7, 8, 9, 10)) == List(8, 9, 7, 6, 10)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (spellboundsorting(List(-3, 0, 1000, 99)) == List(-3, 99, 1000, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (spellboundsorting(List(1, 2, 3, 4, 5)) == List(5, 4, 1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (spellboundsorting(List(0, -1, -2, -3, -4)) == List(-4, -1, -3, -2, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (spellboundsorting(List(100, 101, 102)) == List(100, 101, 102)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
