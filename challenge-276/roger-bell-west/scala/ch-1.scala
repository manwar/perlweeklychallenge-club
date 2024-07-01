import scala.collection.mutable.ListBuffer

object Completeday {
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
  def completeday(a: List[Int]): Int = {
    var ct = 0
    for (c <- combinations(a, 2)) {
      if ((c(0) + c(1)) % 24 == 0) {
        ct += 1
      }
    }
    return ct
  }
  def main(args: Array[String]) {
    if (completeday(List(12, 12, 30, 24, 24)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (completeday(List(72, 48, 24, 5)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (completeday(List(12, 18, 24)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
