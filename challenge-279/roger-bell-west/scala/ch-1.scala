import scala.collection.mutable.ListBuffer

object Sortletters {
  def sortletters(a: List[Char], c: List[Int]): String = {
    var out = ListBuffer.fill(a.length)('x')
    for ((ch, i) <- a.zipWithIndex) {
      out(c(i) - 1) = ch
    }
    out.mkString("")
  }
  def main(args: Array[String]) {
    if (sortletters(List('R', 'E', 'P', 'L'), List(3, 2, 1, 4)) == "PERL") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortletters(List('A', 'U', 'R', 'K'), List(2, 4, 1, 3)) == "RAKU") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortletters(List('O', 'H', 'Y', 'N', 'P', 'T'), List(5, 4, 2, 6, 1, 3)) == "PYTHON") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
