
object Echochamber {
  def echochamber(a: String): String = {
    var out = ""
    for ((c, i) <- a.zipWithIndex ) {
      out += c.toString * (i + 1)
    }
    out
  }
  def main(args: Array[String]) {
    if (echochamber("abca") == "abbcccaaaa") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (echochamber("xyz") == "xyyzzz") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (echochamber("code") == "coodddeeee") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (echochamber("hello") == "heelllllllooooo") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (echochamber("a") == "a") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
