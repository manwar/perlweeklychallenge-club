import scala.collection.mutable.ListBuffer

object Reversepairs {
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
  def reversepairs(a: List[Int]): Int = {
    combinations(a, 2).filter(v => v(1) > 2 * v(0)).length
  }
  def main(args: Array[String]) {
    if (reversepairs(List(1, 3, 2, 3, 1)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reversepairs(List(2, 4, 3, 5, 1)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
