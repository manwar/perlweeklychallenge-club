import scala.util.matching.Regex

object Validnumber {
  def validnumber(a: String): Boolean = {
    val integer = "[-+]?[0-9]+"
    val float = raw"[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)"
    val exponential =
      "(" + integer + "|" + float + ")[Ee]" + integer
    val number =
      "^(" + integer + "|" + float + "|" + exponential + ")$"
    val rx = number.r
    a match {
      case rx(_*) => true
      case _ => false
    }
  }
  def main(args: Array[String]) {
    if (validnumber("1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!validnumber("a")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!validnumber(".")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!validnumber("1.2e4.2")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validnumber("-1.")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validnumber("+1E-8")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validnumber(".44")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
