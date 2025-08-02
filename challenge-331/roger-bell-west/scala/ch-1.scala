
object Lastword {
  def lastword(a: String): Int = {
    val w = a.split(" ").filter (x => x.length > 0)
    w(w.size - 1).length
  }
  def main(args: Array[String]) {
    if (lastword("The Weekly Challenge") == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastword("   Hello   World    ") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastword("Let's begin the fun") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
