
object Maxdiff {
def maxdiff(a: List[Int]): Int = {
    var md = 0
    for (w <- 0 until a.size - 1) {
        for (x <- w + 1 until a.size) {
            for (y <- w + 1 until a.size - 1) {
                if (y != x) {
                    for (z <- y + 1 until a.size) {
                        if (z != x) {
                            val v = (a(w) * a(x) - a(y) * a(z)).abs
                            md = List(md, v).max
                        }
                    }
                }
            }
        }
    }
    md
}
  def main(args: Array[String]) {
    if (maxdiff(List(5, 9, 3, 4, 6)) == 42) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdiff(List(1, -2, 3, -4)) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdiff(List(-3, -1, -2, -4)) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdiff(List(10, 2, 0, 5, 1)) == 50) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxdiff(List(7, 8, 9, 10, 10)) == 44) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
