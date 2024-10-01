
object Thirdmaximum {
  def thirdmaximum(a: List[Int]): Int = {
    val p = a.distinct.sortWith(_ > _)
    if (p.size > 2) {
      return p(2)
    } else {
      return p(0)
    }
  }
  def main(args: Array[String]) {
    if (thirdmaximum(List(5, 6, 4, 1)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thirdmaximum(List(4, 5)) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thirdmaximum(List(1, 2, 2, 3)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
