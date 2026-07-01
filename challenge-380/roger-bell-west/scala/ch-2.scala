
object Reversedegree {
  def reversedegree(a: String): Int = {
    var t = 0
    val z0 = 'z'.toInt + 1
    for ((c, i) <- a.toList.zipWithIndex) {
      t += (z0 - c.toInt) * (i + 1)
    }
    t
  }
  def main(args: Array[String]) {
    if (reversedegree("z") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reversedegree("a") == 26) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reversedegree("bbc") == 147) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reversedegree("racecar") == 560) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reversedegree("zyx") == 14) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
