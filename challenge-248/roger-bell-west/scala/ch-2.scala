import scala.collection.mutable.ListBuffer

object Submatrixsum {
  def submatrixsum(a: List[List[Int]]): List[List[Int]] = {
    var out = new ListBuffer[List[Int]]
    for (y <- 0 until a.length - 1) {
      var row = new ListBuffer[Int]
      for (x <- 0 until a(0).length - 1) {
        var s = 0
        for (ya <- y to y + 1) {
          for (xa <- x to x + 1) {
            s += a(ya)(xa)
          }
        }
        row += s
      }
      out += row.toList
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (submatrixsum(List(List(1, 2, 3, 4), List(5, 6, 7, 8), List(9, 10, 11, 12))) == List(List(14, 18, 22), List(30, 34, 38))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (submatrixsum(List(List(1, 0, 0, 0), List(0, 1, 0, 0), List(0, 0, 1, 0), List(0, 0, 0, 1))) == List(List(2, 1, 0), List(1, 2, 1), List(0, 1, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
