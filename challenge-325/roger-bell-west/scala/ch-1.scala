import scala.collection.mutable

object Consecutiveone {
  def consecutiveone(a: List[Int]): Int = {
    var h = mutable.Map.empty[Int, Int]
    h += ((0, 0))
    var latch = 0
    var latched = false
    for ((n, i) <- a.zipWithIndex) {
      if (n == 1 && !latched) {
        latched = true
        latch = i
      }
      if (n == 0 && latched) {
        latched = false
        h += ((latch, i - latch))
      }
    }
    if (latched) {
      h += ((latch, a.size - latch))
    }
    h.values.max
  }
  def main(args: Array[String]) {
    if (consecutiveone(List(0, 1, 1, 0, 1, 1, 1)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (consecutiveone(List(0, 0, 0, 0)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (consecutiveone(List(1, 0, 1, 0, 1, 1)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
