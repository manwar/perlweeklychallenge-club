
object Mindiff {
  def mindiff(a: List[Int]): Int = {
    var md = 0
    var n = false
    for (i <- 0 until a.size - 1) {
      for (j <- i + 1 until a.size) {
        val diff = (a(i) - a(j)).abs
        if (!n || diff < md) {
          md = diff
          n = true
        }
      }
    }
    md
  }
  def main(args: Array[String]) {
    if (mindiff(List(1, 5, 8, 9)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (mindiff(List(9, 4, 1, 7)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
