
object Maxstrvalue {
  def toInt(in: String): Option[Int] = {
    try {
      Some(Integer.parseInt(in.trim))
    } catch {
      case e: NumberFormatException => None
    }
  }

  def strvalue(a: String): Int = {
    var n = a.length
    toInt(a) match {
      case Some(x) => {
        n = x
      }
      case _ => { }
    }
    n
  }

  def maxstrvalue(a: List[String]): Int = {
    return a.map(x => strvalue(x)).max
  }

  def main(args: Array[String]) {
    if (maxstrvalue(List("123", "45", "6")) == 123) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxstrvalue(List("abc", "de", "fghi")) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxstrvalue(List("0012", "99", "a1b2c")) == 99) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxstrvalue(List("x", "10", "xyz", "007")) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxstrvalue(List("hello123", "2026", "perl")) == 2026) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
