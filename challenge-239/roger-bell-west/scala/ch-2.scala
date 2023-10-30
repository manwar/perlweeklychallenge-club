
object Consistentstrings {
  def consistentstrings(a: List[String], v: String): Int = {
    val vs = v.toSet
    return a.filter(s => s.distinct.forall(c => vs.contains(c))).length
  }
  def main(args: Array[String]) {
      if (consistentstrings(List("ad", "bd", "aaab", "baa", "badab"), "ab") == 2) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (consistentstrings(List("a", "b", "c", "ab", "ac", "bc", "abc"), "ab") == 3) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (consistentstrings(List("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"), "cad") == 4) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
