object Persistencearray {
  def persistence(a: Int): Int = {
    var steps = 0
    var b = a
    while (b > 9) {
      steps += 1
      var p = 1
      while (b > 0) {
        p *= b % 10
        b /= 10
      }
      b = p
    }
    return steps
  }
  def persistencearray(a: List[Int]): List[Int] = {
    val c = a.map(n => n -> persistence(n)).toMap
    var b = a.toArray
    b = b.sortWith((aa, bb) => {
      if (c(aa) == c(bb)) {
        aa < bb
      } else {
        c(aa) < c(bb)
      }
    })
    return b.toList
  }
  def main(args: Array[String]) {
      if (persistencearray(List(15, 99, 1, 34)) == List(1, 15, 34, 99)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (persistencearray(List(50, 25, 33, 22)) == List(22, 33, 50, 25)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
