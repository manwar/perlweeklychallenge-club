import scala.collection.mutable.ListBuffer

object Lastelement {
  def lastelement(a: List[Int]): Int = {
    var b = a.to[ListBuffer]
    var ct = true
    var ex = -1
    while (ct) {
      b = b.sortWith(_ < _)
      val f = b.last
      b = b.dropRight(1)
      val s = b.last
      b = b.dropRight(1)
      if (f > s) {
        b += (f - s)
      }
      if (b.size == 0) {
        ct = false
        ex = 0
      }
      if (b.size == 1) {
        ct = false
        ex = b(0)
      }
    }
    ex
  }
  def main(args: Array[String]) {
    if (lastelement(List(3, 8, 5, 2, 9, 2)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastelement(List(3, 2, 5)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
