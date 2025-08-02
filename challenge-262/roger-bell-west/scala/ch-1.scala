
object Maxpositivenumber {
  def maxpositivenumber(a: List[Int]): Int = {
    List(
      a.filter( c => c > 0 ).size,
      a.filter( c => c < 0 ).size
    ).max
  }
  def main(args: Array[String]) {
    if (maxpositivenumber(List(-3, 1, 2, -1, 3, -2, 4)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxpositivenumber(List(-1, -2, -3, 1)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxpositivenumber(List(1, 2)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
