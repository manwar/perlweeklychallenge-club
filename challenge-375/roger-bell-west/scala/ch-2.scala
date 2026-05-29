
object Findkbeauty {
  def findkbeauty(a: Int, n: Int): Int = {
    var total = 0
    val c = a.toString.toList
    for (t <- c.sliding(n)) {
      val tn = t.mkString("").toInt
      if (a % tn == 0) {
        total += 1
      }
    }
    total
  }
  def main(args: Array[String]) {
    if (findkbeauty(240, 2) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findkbeauty(1020, 2) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findkbeauty(444, 2) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findkbeauty(17, 2) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findkbeauty(123, 1) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
