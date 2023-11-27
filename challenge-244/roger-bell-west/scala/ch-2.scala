import scala.collection.mutable.ListBuffer

object Grouphero {
  def grouphero(nums0: List[Int]): Int = {
    val nums = nums0.sortWith(_ > _)
    var sum = 0
    for (l <- 1 until nums.length + 1) {
      for (c <- combinations(nums, l)) {
        val h = c.last
        sum += h * h * c(0)
      }
    }
    return sum
  }
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
  def main(args: Array[String]) {
      if (grouphero(List(2, 1, 4)) == 141) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
