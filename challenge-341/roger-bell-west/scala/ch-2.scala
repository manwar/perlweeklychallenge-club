
object Reverseprefix {
  def reverseprefix(a: String, f: String): String = {
    var c = a.toList
    val fc = f.toList(0)
    val p = c.indexOf(fc)
    if (p >= 0) {
      var jr = c.slice(0, p + 1).reverse
      c = jr ++ c.reverse.slice(0, c.size - p - 1).reverse
    }
    c.mkString
  }
  def main(args: Array[String]) {
    if (reverseprefix("programming", "g") == "gorpramming") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseprefix("hello", "h") == "hello") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseprefix("abcdefghij", "h") == "hgfedcbaij") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseprefix("reverse", "s") == "srevere") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseprefix("perl", "r") == "repl") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
