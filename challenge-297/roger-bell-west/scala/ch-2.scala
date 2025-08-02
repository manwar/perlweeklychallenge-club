
object Semiorderedpermutation {
  def semiorderedpermutation(a: List[Int]): Int = {
    val en = a.size
    var s = 1
    var e = en - 1
    for ((n, i) <- a.zipWithIndex) {
      if (n == 1) {
        s = i
      }
      if (n == en) {
        e = i
      }
    }
    var r = s + (en - 1 - e)
    if (s > e) {
      r -= 1
    }
    r
  }
  def main(args: Array[String]) {
    if (semiorderedpermutation(List(2, 1, 4, 3)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (semiorderedpermutation(List(2, 4, 1, 3)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (semiorderedpermutation(List(1, 3, 2, 4, 5)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
