
object Sortbyonebits {
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
  def sortbyonebits(a: List[Int]): List[Int] = {
    val c = a.map(n => n -> popcount64(n)).toMap
    var b = a.toArray
    b = b.sortWith((aa, bb) => {
      if (c(aa) == c(bb)) {
        aa < bb
      } else {
        c(aa) < c(bb)
      }
    })
    return b.toList
  }
  def main(args: Array[String]) {
    if (sortbyonebits(List(0, 1, 2, 3, 4, 5, 6, 7, 8)) == List(0, 1, 2, 4, 8, 3, 5, 6, 7)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortbyonebits(List(1024, 512, 256, 128, 64)) == List(64, 128, 256, 512, 1024)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
