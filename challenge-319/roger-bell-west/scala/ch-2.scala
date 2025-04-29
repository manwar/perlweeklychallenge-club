
object Minimumcommon {
  def minimumcommon(a: List[Int], b: List[Int]): Int = {
    val aa = a.toSet
    val bb = b.toSet
    val cc = aa.intersect(bb).toList
    if (cc.size == 0) {
       -1
    } else {
      cc.min
    }
  }
  def main(args: Array[String]) {
    if (minimumcommon(List(1, 2, 3, 4), List(3, 4, 5, 6)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minimumcommon(List(1, 2, 3), List(2, 4)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minimumcommon(List(1, 2, 3, 4), List(5, 6, 7, 8)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
