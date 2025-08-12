
object Rangesum {
  def rangesum(a: List[Int], s: Int, e: Int): Int = {
    a.slice(s, e + 1).sum
  }
  def main(args: Array[String]) {
    if (rangesum(List(-2, 0, 3, -5, 2, -1), 0, 2) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rangesum(List(1, -2, 3, -4, 5), 1, 3) == -3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rangesum(List(1, 0, 2, -1, 3), 3, 4) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rangesum(List(-5, 4, -3, 2, -1, 0), 0, 3) == -2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rangesum(List(-1, 0, 2, -3, -2, 1), 0, 2) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
