
object Multiplybytwo {
  def multiplybytwo(a: List[Int], start: Int): Int = {
    val p = a.toSet
    var v = start
    while (p.contains(v)) {
      v *= 2
    }
    v
  }
  def main(args: Array[String]) {
      if (multiplybytwo(List(5, 3, 6, 1, 12), 3) == 24) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (multiplybytwo(List(1, 2, 4, 3), 1) == 8) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (multiplybytwo(List(5, 6, 7), 2) == 2) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
