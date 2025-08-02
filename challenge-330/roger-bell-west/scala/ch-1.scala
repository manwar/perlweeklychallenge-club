import scala.collection.mutable.ListBuffer

object Cleardigits {
  def cleardigits(a: String): String = {
    var out = new ListBuffer[Char]
    for (c <- a) {
      if (c.isDigit) {
        out = out.dropRight(1)
      } else {
        out += c
      }
    }
    out.mkString
  }
  def main(args: Array[String]) {
    if (cleardigits("cab12") == "c") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (cleardigits("xy99") == "") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (cleardigits("pa1erl") == "perl") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
