import scala.collection.mutable.ListBuffer

object Goatlatin {
  def is_vowel(c: Char): Boolean = {
    return c.toLower match {
      case 'a' | 'e' | 'i' | 'o' | 'u' => true
      case _ => false
    }
  }
  def goatlatin(a: String): String = {
    var out = new ListBuffer[String];
    for ((word, i) <- a.split(" ").zipWithIndex){
      var c = word.toList
      var nw = word;
      if (!is_vowel(c(0))) {
        var co = c.tail.to[ListBuffer];
        co += c.head;
        nw = co.mkString;
      }
      nw += "ma";
      for (ix <- 0 to i) {
        nw += "a";
      }
      out += nw;
    }
    out.mkString(" ")
  }
  def main(args: Array[String]) {
    if (goatlatin("I love Perl") == "Imaa ovelmaaa erlPmaaaa") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goatlatin("Perl and Raku are friends") == "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goatlatin("The Weekly Challenge") == "heTmaa eeklyWmaaa hallengeCmaaaa") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
