
object Middleindex {
  def middleindex(a: List[Int]): Int = {
    var r = a.sum
    var l = 0
    var latch = -1
    for ((c, i) <- a.zipWithIndex) {
      r -= c
      if (r == l && latch == -1) {
        latch = i
      }
      l += c
    }
    latch
  }
  def main(args: Array[String]) {
    if (middleindex(List(2, 3, -1, 8, 4)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (middleindex(List(1, -1, 4)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (middleindex(List(2, 5)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
