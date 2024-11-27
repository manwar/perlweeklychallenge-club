
object Twicelargest {
  def twicelargest(a: List[Int]): Int = {
    val p = a.sortWith(_ > _)
    var ret = -1
    if (p(0) >= 2 * p(1)) {
      for ((c, i) <- a.zipWithIndex) {
        if (c == p(0) && ret == -1) {
          ret = i
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (twicelargest(List(2, 4, 1, 0)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (twicelargest(List(1, 2, 3, 4)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
