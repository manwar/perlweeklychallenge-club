
object Sumofvalues {
  def popcount64(x0: Int): Int = {
    val M1  = 0x5555555555555555L
    val M2  = 0x3333333333333333L
    val M4  = 0x0f0f0f0f0f0f0f0fL
    val H01 = 0x0101010101010101L
    var x = x0.toLong
    x -= (x >> 1) & M1
    x = (x & M2) + ((x >> 2) & M2)
    x = (x + (x >> 4)) & M4
    return ((x * H01) >> 56).toInt
  }
  def sumofvalues(a: List[Int], k: Int ): Int = {
    var s = 0
    for ((v, i) <- a.zipWithIndex) {
      if (popcount64(i) == k) {
        s += v
      }
    }
    s
  }
  def main(args: Array[String]) {
    if (sumofvalues(List(2, 5, 9, 11, 3), 1) == 17) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sumofvalues(List(2, 5, 9, 11, 3), 2) == 11) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sumofvalues(List(2, 5, 9, 11, 3), 0) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
