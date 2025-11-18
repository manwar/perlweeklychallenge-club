
object Stringalike {
  def is_vowel(c: Char): Boolean = {
    return c.toLower match {
      case 'a' | 'e' | 'i' | 'o' | 'u' => true
      case _ => false
    }
  }

  def stringalike(a: String): Boolean = {
    if (a.length % 2 == 1) {
      false
    } else {
      var vt = 0
      var mode = 1
      var av = false
      for ((c, i) <- a.toList.zipWithIndex) {
        if (i * 2 == a.length) {
          mode = -1
        }
        if (is_vowel(c)) {
          av = true
          vt += mode
        }
      }
      return av && (vt == 0)
    }
  }

  def main(args: Array[String]) {
    if (!stringalike("textbook")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (stringalike("book")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (stringalike("AbCdEfGh")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!stringalike("rhythmmyth")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!stringalike("UmpireeAudio")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
