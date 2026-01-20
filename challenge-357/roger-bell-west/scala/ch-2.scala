import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Uniquefractiongenerator {
  def gcd(m0: Int,n0: Int): Int = {
    var m=m0
    var n=n0
    while (n != 0) {
      val tmp=m % n
      m = n
      n = tmp
    }
    m
  }

  def uniquefractiongenerator(a: Int): List[String] = {
    var den = 1
    for (dn <- 2 to a) {
      den *= dn
    }
    var f = mutable.Set.empty[Int]
    for (d <- 1 to a) {
      val nd = den / d
      for (n <- 1 to a) {
        f += n * nd
      }
    }
    var out = new ListBuffer[String]
    for (n <- f.toList.sortWith(_ < _)) {
      val g = gcd(n, den)
      val nn = n / g
      val nd = den / g
      out += (nn.toString + "/" + nd.toString)
    }
    out.toList
  }

  def main(args: Array[String]) {
    if (uniquefractiongenerator(3) == List("1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(4) == List("1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(1) == List("1/1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(6) == List("1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1", "6/1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(5) == List("1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
