
object Zerofriend {
  def zerofriend(a: List[Int]): Int = {
    val b = a.map(x => x.abs).min
    if (a.contains(b)) {
      b
    } else {
      -b
    }
  }

  def main(args: Array[String]) {
    if (zerofriend(List(4, 2, -1, 3, -2)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zerofriend(List(-5, 5, -3, 3, -1, 1)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zerofriend(List(7, -3, 0, 2, -8)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zerofriend(List(-2, -5, -1, -8)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zerofriend(List(-2, 2, -4, 4, -1, 1)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
