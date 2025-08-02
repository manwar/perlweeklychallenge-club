
object Stringscore {
  def stringscore(a: String): Int = {
    var out = 0
    val c = a.toList
    for (i <- c.sliding(2)) {
      out += (i(0).toInt - i(1).toInt).abs
    }
    out
  }
  def main(args: Array[String]) {
    if (stringscore("hello") == 13) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (stringscore("perl") == 30) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (stringscore("raku") == 37) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
