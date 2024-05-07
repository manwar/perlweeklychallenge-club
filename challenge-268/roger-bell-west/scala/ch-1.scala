
object Magicnumber {
  def magicnumber(a: List[Int], b: List[Int]): Int = {
    return b.min - a.min
  }
  def main(args: Array[String]) {
    if (magicnumber(List(3, 7, 5), List(9, 5, 7)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (magicnumber(List(1, 2, 1), List(5, 4, 4)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (magicnumber(List(2), List(5)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
