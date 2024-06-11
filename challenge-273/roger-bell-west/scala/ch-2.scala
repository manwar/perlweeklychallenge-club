
object Baftera {
def baftera(a: String): Boolean = {
    val firstb = a.indexOf('b')
    val lasta = a.lastIndexOf('a')
    if (firstb == -1) {
        return false
    }
    if (lasta == -1) {
        return true
    }
    lasta < firstb
}
  def main(args: Array[String]) {
    if (baftera("aabb")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!baftera("abab")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!baftera("aaa")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (baftera("bbb")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
