import scala.collection.mutable.ListBuffer

object Reversevowels {
  def is_vowel(c: Char): Boolean = {
    return c.toLower match {
      case 'a' | 'e' | 'i' | 'o' | 'u' => true
      case _ => false
    }
  }
  def reversevowels(a: String): String = {
    val p = a.toList
    val q = p.filter(c => is_vowel(c))
    var qi = q.length
    var o = new ListBuffer[Char]
    for (c <- p) {
      if (is_vowel(c)) {
        qi -= 1;
        var nc = q(qi)
        if (Character.isUpperCase(c)) {
          nc = nc.toUpper
        } else {
          nc = nc.toLower
        }
        o += nc
      } else {
        o += c
      }
    }
    return o.mkString
  }
  def main(args: Array[String]) {
      if (reversevowels("Raku") == "Ruka") {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (reversevowels("Perl") == "Perl") {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (reversevowels("Julia") == "Jaliu") {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (reversevowels("Uiua") == "Auiu") {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
