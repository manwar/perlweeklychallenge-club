import scala.collection.mutable.ListBuffer

object Rearrangespaces {
  def rearrangespaces(a: String): String = {
    var words = new ListBuffer[String]
    var spaces = 0
    var ww = ""
    for (c <- a) {
      if (c == ' ') {
        spaces += 1
        if (ww != "") {
          words += ww
          ww = ""
        }
      } else {
        ww += c
      }
    }
    if (ww != "") {
      words += ww
    }
    var spdiv = 0
    var remainder = spaces
    var divs = words.size - 1
    if (divs > 0) {
      spdiv = spaces / divs
      remainder = spaces % divs
    }
    var out = words.mkString(" " * spdiv)
    if (remainder > 0) {
      out += " " * remainder
    }
    out
  }
  def main(args: Array[String]) {
    if (rearrangespaces("  challenge  ") == "challenge    ") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rearrangespaces("coding  is  fun") == "coding  is  fun") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rearrangespaces("a b c  d") == "a b c d ") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rearrangespaces("  team      pwc  ") == "team          pwc") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rearrangespaces("   the  weekly  challenge  ") == "the    weekly    challenge ") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
