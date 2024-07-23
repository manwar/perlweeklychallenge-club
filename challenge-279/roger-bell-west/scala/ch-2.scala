
object Splitstring {
  def splitstring(a: String): Boolean = {
    var n = 0
    for (cc <- a.toList) {
      cc.toLower match {
        case 'a' | 'e' | 'i' | 'o' | 'u' => { n += 1 }
        case _ => { }
      }
    }
    n % 2 == 0
  }
  def main(args: Array[String]) {
    if (!splitstring("perl")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (splitstring("book")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (splitstring("goodmorning")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
