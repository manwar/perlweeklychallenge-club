
object Stepbystep {
  def stepbystep(a: List[Int]): Int = {
    var mv = 0
    var tot = 0
    for (s <- a) {
      tot += s
      if (mv > tot) {
        mv = tot
      }
    }
    1 - mv
  }
  def main(args: Array[String]) {
    if (stepbystep(List(-3, 2, -3, 4, 2)) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (stepbystep(List(1, 2)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (stepbystep(List(1, -2, -3)) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
