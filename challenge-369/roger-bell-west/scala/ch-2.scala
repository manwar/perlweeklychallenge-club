import scala.collection.mutable.ListBuffer

object Groupdivision {
  def groupdivision(a0: String, sz: Int, pad: String): List[String] = {
    var a = a0
    while (a.length % sz != 0) {
      a += pad
    }
    var out = new ListBuffer[String]
    var i = 0
    while (i < a.length) {
      out += a.slice(i, i + sz)
      i += sz
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (groupdivision("RakuPerl", 4, "*") == List("Raku", "Perl")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupdivision("Python", 5, "0") == List("Pytho", "n0000")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupdivision("12345", 3, "x") == List("123", "45x")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupdivision("HelloWorld", 3, "_") == List("Hel", "loW", "orl", "d__")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupdivision("AI", 5, "!") == List("AI!!!")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
