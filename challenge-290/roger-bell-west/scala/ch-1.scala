
object Doubleexist {
  def doubleexist(a: List[Int]): Boolean = {
    for (i <- 0 until a.length - 1) {
      for (j <- i + 1 until a.length) {
        if (a(i) == 2 * a(j) || a(j) == 2 * a(i)) {
          return true
        }
      }
    }
    false
  }
  def main(args: Array[String]) {
    if (doubleexist(List(6, 2, 3, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!doubleexist(List(3, 1, 4, 13))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (doubleexist(List(2, 1, 4, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
