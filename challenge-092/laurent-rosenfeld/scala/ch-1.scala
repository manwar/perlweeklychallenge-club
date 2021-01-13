import scala.collection.mutable.Set

object Main {
  def main(args: Array[String]): Unit = {
    val (str1, str2) =
      if (args.size == 2) (args(0), args(1)) else ("abc", "xyz")
    println(s"args = $str1 and $str2")
    println(isIsomorphic(str1, str2))
  }
  def isIsomorphic(str1: String, str2: String): Int = {
    if (str1.length != str2.length) return 0
    var transcode: Map[Char, Char] = Map()
    var seen: Set[Char] = Set()
    for (i <- 0 to str1.length - 1) {
      if (transcode.contains(str1(i))) {
        if (str1(i) != str2(i)) { return 0 }
      } else {
        if (seen.contains(str2(i))) return 0
        transcode += (str1(i) -> str2(i))
        seen += str2(i)
      }
    }
    return 1
  }
}
