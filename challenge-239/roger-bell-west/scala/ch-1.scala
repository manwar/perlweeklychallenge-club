
object Samestring {
  def samestring(a: List[String], b: List[String]): Boolean = {
    return a.mkString("") == b.mkString("")
  }
  def main(args: Array[String]) {
      if (samestring(List("ab", "c"), List("a", "bc"))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (!samestring(List("ab", "c"), List("ac", "b"))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (samestring(List("ab", "cd", "e"), List("abcde"))) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
