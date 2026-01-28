
object Encryptedstring {

  def posmod(x: Int, y: Int): Int = {
    var z = x % y
    while (z < 0) {
      z += y
    }
    z
  }

  def rotx(a: Char, offset: Int): Char = {
    var o = posmod(offset, 26)
    var base = 0
    var ret = ' '
    if (a >= 'a' && a <= 'z') {
      base = 'a'.toInt
    } else if (a >= 'A' && a <= 'Z') {
      base = 'A'.toInt
    } else {
      ret = a
    }
    if (ret != a) {
      val c = posmod(a.toInt - base + o, 26) + base
      ret = c.toChar
    }
    ret
  }

  def encryptedstring(a: String, offset: Int): String = {
    return a.toList.map(x => rotx(x, offset)).mkString
  }

  def main(args: Array[String]) {
    if (encryptedstring("abc", 1) == "bcd") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (encryptedstring("xyz", 2) == "zab") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (encryptedstring("abc", 27) == "bcd") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (encryptedstring("hello", 5) == "mjqqt") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (encryptedstring("perl", 26) == "perl") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
