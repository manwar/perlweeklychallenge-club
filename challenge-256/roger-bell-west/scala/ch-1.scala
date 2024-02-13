import scala.collection.mutable

object Maximumpairs {
  def maximumpairs(a: List[String]): Int = {
    var n = 0
    var r = mutable.Set.empty[String]
    for (s <- a) {
      val t = s.reverse
      if (r.contains(t)) {
        n += 1
      } else {
        r += s
      }
    }
    return n
  }
  def main(args: Array[String]) {
    if (maximumpairs(List("ab", "de", "ed", "bc")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumpairs(List("aa", "ba", "cd", "ed")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumpairs(List("uv", "qp", "st", "vu", "mn", "pq")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
