import scala.collection.mutable.ListBuffer

object Missingletter {
  def missingletter(a: String): String = {
    val c = a.toList.filter(x => !x.isWhitespace).map(x => x.toInt)
    var d = new ListBuffer[Int]
    for (i <- c.sliding(2)) {
      if (i(0) == 63 || i(1) == 63) {
        d += 0
      } else {
        d += i(1) - i(0)
      }
    }
    var ch = 0
    for ((delta, n) <- d.zipWithIndex) {
      if (ch == 0 && delta == 0) {
        if (n < 2) {
          ch = c(n + 2) - d(n + 2)
        } else {
          ch = c(n) + d(n - 2)
        }
      }
    }
    ch.toChar.toString
  }
  def main(args: Array[String]) {
    if (missingletter("a c ? g i") == "e") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (missingletter("a d ? j m") == "g") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (missingletter("a e ? m q") == "i") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (missingletter("a c f ? k") == "h") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (missingletter("b e g ? l") == "j") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
