
object Hammingdistance {
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
  def hammingdistance(a: List[Int]): Int = {
    var t = 0
    for (i <- 0 until a.size - 1) {
      for (j <- i + 1 until a.size) {
        t += popcount64(a(i) ^ a(j))
      }
    }
    t
  }
  def main(args: Array[String]) {
    if (hammingdistance(List(4, 14, 2)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (hammingdistance(List(4, 14, 4)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
