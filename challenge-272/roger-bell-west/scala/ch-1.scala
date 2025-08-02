object Defrangip {
  def defrangip(a: String): String = {
    a.replaceAll("\\.", "[.]")
  }
  def main(args: Array[String]) {
    if (defrangip("1.1.1.1") == "1[.]1[.]1[.]1") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (defrangip("255.101.1.0") == "255[.]101[.]1[.]0") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
