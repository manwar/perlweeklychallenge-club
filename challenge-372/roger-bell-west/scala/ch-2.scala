
object Largestsubstring {
  def largestsubstring(a: String): Int = {
    var cc = a.toList
    var offset = 0
    var break = false
    for (off <- cc.size - 1 to 1 by -1) {
      if (!break) {
        for (x <- 0 until cc.size - off) {
          if (!break && cc(x) == cc(x + off)) {
            offset = off - 1
            break = true
          }
        }
      }
    }
    offset
  }
  def main(args: Array[String]) {
    if (largestsubstring("aaaaa") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestsubstring("abcdeba") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestsubstring("abbc") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestsubstring("abcaacbc") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestsubstring("laptop") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
