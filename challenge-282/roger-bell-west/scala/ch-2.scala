
object Changingkeys {
  def changingkeys(a: String): Int = {
    var oc = 'x'
    var out = 0
    for ((c, i) <- a.toLowerCase.zipWithIndex) {
      if (i == 0) {
        oc = c
      } else if (c != oc) {
        oc = c
        out += 1
      }
    }
    out
  }
  def main(args: Array[String]) {
    if (changingkeys("pPeERrLl") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (changingkeys("rRr") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (changingkeys("GoO") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
