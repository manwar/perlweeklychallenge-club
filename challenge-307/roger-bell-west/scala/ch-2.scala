import scala.collection.mutable.ListBuffer

object Findanagrams {
  def findanagrams(a: List[String]): Int = {
    var b = new ListBuffer[String]
    for (s <- a) {
      b += s.toList.sortWith(_ < _).toString
    }
    var out = 1
    for (s <- b.sliding(2)) {
      if (s(0) != s(1)) {
        out += 1
      }
    }
    out
  }
  def main(args: Array[String]) {
    if (findanagrams(List("acca", "dog", "god", "perl", "repl")) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findanagrams(List("abba", "baba", "aabb", "ab", "ab")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
