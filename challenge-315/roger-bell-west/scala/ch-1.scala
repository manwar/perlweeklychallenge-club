import scala.collection.mutable.ListBuffer

object Findwords {
  def findwords(a: List[String], b: String): List[Int] = {
    var t = new ListBuffer[Int]
    for ((x, i) <- a.zipWithIndex) {
      if (x.indexOf(b) != -1) {
        t += i
      }
    }
    t.toList
  }
  def main(args: Array[String]) {
    if (findwords(List("the", "weekly", "challenge"), "e") == List(0, 1, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findwords(List("perl", "raku", "python"), "p") == List(0, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findwords(List("abc", "def", "bbb", "bcd"), "b") == List(0, 2, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
