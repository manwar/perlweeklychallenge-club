import scala.collection.mutable.ListBuffer

object Reverseequals {
  def reverseequals(a: List[Int], b: List[Int]): Boolean = {
    var ret = false
    if (a == b) {
      ret = true
    } else {
      for (i <- 0 until a.size - 1) {
        for (j <- i + 1 until a.size) {
          var c = a.to[ListBuffer]
          for (x <- i to j) {
            c(x) = a(j - (x - i))
          }
          if (c == b) {
            ret = true
          }
        }
      }
    }
    ret
  }

  def main(args: Array[String]) {
    if (reverseequals(List(3, 2, 1, 4), List(1, 2, 3, 4))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reverseequals(List(1, 3, 4), List(4, 1, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseequals(List(2), List(2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
