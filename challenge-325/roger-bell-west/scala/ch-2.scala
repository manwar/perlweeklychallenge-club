import scala.collection.mutable.ListBuffer

object Finalprice {
  def finalprice(a: List[Int]): List[Int] = {
    var out = new ListBuffer[Int]
    for ((n, i) <- a.zipWithIndex) {
      var discount = 0
      var mi = i + 1
      if (mi < a.size) {
        var lp = true
        while (lp) {
          if (a(mi) <= n) {
            discount = a(mi)
            lp = false
          }
          mi += 1
          if (mi >= a.size) {
            lp = false
          }
        }
      }
      out += (n - discount)
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (finalprice(List(8, 4, 6, 2, 3)) == List(4, 2, 4, 2, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finalprice(List(1, 2, 3, 4, 5)) == List(1, 2, 3, 4, 5)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finalprice(List(7, 1, 1, 5)) == List(6, 0, 1, 5)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
