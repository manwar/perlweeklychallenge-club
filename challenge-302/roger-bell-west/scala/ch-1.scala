import scala.collection.mutable.ListBuffer

object Onesandzeroes {
  def onesandzeroes(a: List[String], zeroes: Int, ones: Int): Int = {
    var ax = new ListBuffer[Tuple2[Int, Int]]
    for (ns <- a) {
      var o = 0
      var n = 0
      for (c <- ns) {
        c match {
          case '0' => { o += 1 }
          case '1' => { n += 1 }
          case _ => { }
        }
      }
      ax += Tuple2(o, n)
    }
    var mx = 0
    for (mask <- 1 until (1 << ax.size)) {
      var o = 0
      var n = 0
      var ct = 0
      for ((x, i) <- ax.zipWithIndex) {
        if ((mask & (1 << i)) > 0) {
          o = o + x._1
          n = n + x._2
          ct += 1
        }
        if (o <= zeroes && n <= ones) {
          mx = List(mx, ct).max
        }
      }
    }
    mx
  }
  def main(args: Array[String]) {
    if (onesandzeroes(List("10", "0001", "111001", "1", "0"), 5, 3) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (onesandzeroes(List("10", "1", "0"), 1, 1) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
