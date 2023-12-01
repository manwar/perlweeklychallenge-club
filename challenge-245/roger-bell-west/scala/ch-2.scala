import scala.collection.mutable.ListBuffer

object Largestofthree {
  def combinations(arr: List[Int], k: Int): List[List[Int]] = {
    var c = new ListBuffer[Int]()
    for (i <- 0 until k) {
      c += i
    }
    c += arr.length
    c += 0
    var out = new ListBuffer[List[Int]]()
    var cont = true
    while (cont) {
      var inner = new ListBuffer[Int]()
      for (i <- List.range(k-1, -1, -1)) {
        inner += arr(c(i))
      }
      out += inner.toList
      var j = 0
      while (c(j) + 1 == c(j + 1)) {
        c(j) = j
        j += 1
      }
      if (j >= k) {
        cont = false
      } else {
        c(j) += 1
      }
    }
    return out.toList
  }
  def largestofthree(digits: List[Int]): Int = {
    val ordered = digits.sortWith(_ < _)
    var mx = 0
    for (n <- ordered.length - 1 to 0 by -1) {
      for (c <- combinations(ordered, n + 1)) {
        var t = 0
        for (d <- c) {
          t *= 10
          t += d
        }
        if (t > mx && t % 3 == 0) {
          mx = t
        }
      }
    }
    return mx
  }
  def main(args: Array[String]) {
    if (largestofthree(List(8, 1, 9)) == 981) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestofthree(List(8, 6, 7, 1, 0)) == 8760) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
