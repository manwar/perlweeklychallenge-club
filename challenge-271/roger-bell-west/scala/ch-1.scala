
object Maximumones {
  def maximumones(a: List[List[Int]]): Int = {
    val ax = a.map(r => r.sum).toList
    val am = ax.max
    ax.indexOf(am) + 1
  }
  def main(args: Array[String]) {
    if (maximumones(List(List(0, 1), List(1, 0))) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumones(List(List(0, 0, 0), List(1, 0, 1))) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumones(List(List(0, 0), List(1, 1), List(0, 0))) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
