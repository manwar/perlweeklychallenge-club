import scala.collection.mutable

object Mostfrequentword {
  def mostfrequentword(para: String, banned: String): String = {
    var words = mutable.Map.empty[String, Int].withDefaultValue(0)
    for (w <- para.split("[^A-Za-z]+").filter(n => n.length > 0)) {
      words += (w -> (words(w) + 1))
    }
    words.remove(banned)
    val m = words.values.max
    val l = words.keys.filter(i => words(i) == m).toList
    return l(0)
  }
  def main(args: Array[String]) {
    if (mostfrequentword("Joe hit a ball, the hit ball flew far after it was hit.", "hit") == "ball") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (mostfrequentword("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the") == "Perl") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
