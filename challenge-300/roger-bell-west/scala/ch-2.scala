import scala.collection.mutable.ListBuffer

object Nestedarray {
  def nestedarray(a: List[Int]): Int = {
    var arr = 0
    for (i <- 0 until a.size) {
      var trail = new ListBuffer[Int]
      var j = i
      var lp = true
      while (lp) {
        j = a(j)
        if (trail.contains(j)) {
          lp = false
        } else {
          trail += j
        }
      }
      arr = List(arr, trail.size).max
    }
    arr
  }
  def main(args: Array[String]) {
    if (nestedarray(List(5, 4, 0, 3, 1, 6, 2)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nestedarray(List(0, 1, 2)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
