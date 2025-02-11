
object Countcommon {
  def countcommon(a: List[String], b: List[String]): Int = {
    val aa = a.toSet
    val bb = b.toSet
    return aa.intersect(bb).toList.size
  }
  def main(args: Array[String]) {
    if (countcommon(List("perl", "weekly", "challenge"), List("raku", "weekly", "challenge")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countcommon(List("perl", "raku", "python"), List("python", "java")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countcommon(List("guest", "contribution"), List("fun", "weekly", "challenge")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}