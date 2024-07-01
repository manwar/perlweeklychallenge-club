
object Brokenkeys {
  def brokenkeys(a: String, k: List[Char]): Int = {
    var out = 0
    val failset: Set[Char] = k.map(c => c.toLower).toSet
    for (word <- a.split(" ")) {
      val wordset: Set[Char] = word.toLowerCase().toSet
      if ((failset & wordset).size == 0) {
        out += 1
      }
    }
    return out
  }

  def main(args: Array[String]) {
    if (brokenkeys("Perl Weekly Challenge", List('l', 'a')) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeys("Perl and Raku", List('a')) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeys("Well done Team PWC", List('l', 'o')) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
