
object Upperlower {
  def upperlower(a: String): String = {
    var out = new String
    for (c <- a) {
      out += (c.toInt ^ 32).toChar
    }
    out
  }
  def main(args: Array[String]) {
    if (upperlower("pERL") == "Perl") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (upperlower("rakU") == "RAKu") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (upperlower("PyThOn") == "pYtHoN") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
