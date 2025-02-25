import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Threedigitseven {
  def permute(aa: List[Int]): ListBuffer[List[Int]] = {
    var a = new ListBuffer[Int]
    for (i <- aa) {
      a += i
    }
    var out = new ListBuffer[List[Int]]
    val n = a.size
    var c = new ListBuffer[Int]
    for (i <- 0 to n-1) {
      c += 0
    }
    out += a.toList
    var i = 0
    while (i < n) {
      if (c(i) < i) {
        if (i % 2 == 0) {
          val tmp = a(0)
          a(0) = a(i)
          a(i) = tmp
        } else {
          val tmp = a(c(i))
          a(c(i)) = a(i)
          a(i) = tmp
        }
        out += a.toList
        c(i) += 1
        i = 0
      } else {
        c(i) = 0
        i += 1
      }
    }
    return out
  }
  def concatenate(a: List[Int]): Int = {
    val ax = a.map(x => x.toString)
    ax.mkString("").toInt
  }
  def threedigitseven(a: List[Int]): List[Int] = {
    var s = mutable.Set.empty[Int]
    for (mask <- 1 until 1 << a.size) {
      val pl = a.zipWithIndex
        .filter{case (v, i) => (1 << i & mask) > 0 }
        .map{case (v, i) => v}
      for (px <- permute(pl)) {
        val c = concatenate(px)
        if (c >= 100 && c <= 999 && c % 2 == 0) {
          s += c
        }
      }
    }
    s.toList.sortWith(_ < _)
  }
  def main(args: Array[String]) {
    if (threedigitseven(List(2, 1, 3, 0)) == List(102, 120, 130, 132, 210, 230, 302, 310, 312, 320)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (threedigitseven(List(2, 2, 8, 8, 2)) == List(222, 228, 282, 288, 822, 828, 882)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
