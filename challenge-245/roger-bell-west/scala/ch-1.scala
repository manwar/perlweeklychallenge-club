
object Sortlanguage {
  def sortlanguage(langs: List[String], popularities: List[Int]): List[String] = {
    var ix = (0 to langs.length - 1).toList
    ix = ix.sortWith((a, b) => popularities(a) < popularities(b))
    return ix.map(n => langs(n)).toList
  }
  def main(args: Array[String]) {
    if (sortlanguage(List("perl", "c", "python"), List(2, 1, 3)) == List("c", "perl", "python")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortlanguage(List("c++", "haskell", "java"), List(1, 3, 2)) == List("c++", "java", "haskell")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
