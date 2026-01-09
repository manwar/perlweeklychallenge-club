
object Thousandseparator {
  def thousandseparator(a: Int): String = {
    var out = ""
    val s = a.toString
    val offset = 2 - ((s.length + 2) % 3)
    for ((d, i) <- s.toList.zipWithIndex) {
      if (i > 0 && (i + offset) % 3 == 0) {
        out += ','
      }
      out += d
    }
    out
  }

  def main(args: Array[String]) {
    if (thousandseparator(123) == "123") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thousandseparator(1234) == "1,234") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thousandseparator(1000000) == "1,000,000") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thousandseparator(1) == "1") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thousandseparator(12345) == "12,345") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
