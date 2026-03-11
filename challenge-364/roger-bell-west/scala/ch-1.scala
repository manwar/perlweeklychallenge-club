
object Decryptstring {
  def decryptstring(a: String): String = {
    var out = ""
    val c = a.toList
    var s = 0
    while (s < c.size) {
      var m = c(s).toInt - 48
      if (s + 2 < c.size && c(s + 2) == '#') {
        m = m * 10 + c(s + 1).toInt - 48
        s += 2
      }
      s += 1
      out += (96 + m).toChar
    }
    out
  }
  def main(args: Array[String]) {
    if (decryptstring("10#11#12") == "jkab") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decryptstring("1326#") == "acz") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decryptstring("25#24#123") == "yxabc") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decryptstring("20#5") == "te") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decryptstring("1910#26#") == "aijz") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
