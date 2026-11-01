
object Absentsmallestpositive {
  def absentsmallestpositive(a: List[Int]): Int = {
    val tot = a.sum
    val ex = a.toSet
    val mul = a.size
    var n = 1
    var lp = true
    while (lp) {
      if (n * mul > tot && !ex.contains(n)) {
        lp = false
      } else {
        n += 1
      }
    }
    n
  }
  def main(args: Array[String]) {
    if (absentsmallestpositive(List(1, 2, 4, 5, 6)) == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(List(-5, -2, -1, 3)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(List(1, 2, 3)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(List(2, 3, 7, 8)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(List(1, 1, 1, 10)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
