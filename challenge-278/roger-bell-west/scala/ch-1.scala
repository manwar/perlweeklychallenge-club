import scala.collection.mutable.ListBuffer
import scala.util.matching.Regex

object Sortstring {
  def sortstring(a: String): String = {
    var words = a.split(" ")
    var out = ListBuffer.fill(words.length)("")
    val re: Regex = "^(.*?)([0-9]+)$".r
    for (w <- words) {
      val mr = w match {
        case re(st, nn) => {
          val index = nn.toInt - 1
          out(index) = st
        }
      }
    }
    out.mkString(" ")
  }
  def main(args: Array[String]) {
    if (sortstring("and2 Raku3 cousins5 Perl1 are4") == "Perl and Raku are cousins") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortstring("guest6 Python1 most4 the3 popular5 is2 language7") == "Python is the most popular guest language") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortstring("Challenge3 The1 Weekly2") == "The Weekly Challenge") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
