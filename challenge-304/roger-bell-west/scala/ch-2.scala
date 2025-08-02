
object Maximumaverage {
  def maximumaverage(a: List[Int], n: Int): Float = {
    var mx = 0
    for (s <- a.sliding(n)) {
      mx = List(mx, s.sum).max
    }
    mx.toFloat / n.toFloat
  }
  def main(args: Array[String]) {
    if (maximumaverage(List(1, 12, -5, -6, 50, 3), 4) == 12.75) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumaverage(List(5), 1) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
