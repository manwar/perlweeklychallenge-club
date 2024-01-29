import scala.collection.mutable.ListBuffer

object Splitstrings {
  def splitstrings(a: List[String], sep: String): List[String] = {
    var p = new ListBuffer[String]
    for (s <- a) {
      p.append(s.split("[" + sep + "]").filter(n => n.length > 0): _*)
    }
    return p.toList
  }
  def main(args: Array[String]) {
    if (splitstrings(List("one.two.three", "four.five", "six"), ".") == List("one", "two", "three", "four", "five", "six")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (splitstrings(List("$perl$$", "$$raku$"), "$") == List("perl", "raku")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
