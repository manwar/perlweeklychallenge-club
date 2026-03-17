
object Alphabetindexdigitsum {
  def alphabetindexdigitsum(a: String, k: Int): Int = {
    var st = ""
    for (c <- a) {
      st += (c.toInt - 96).toString
    }
    var v = st.toInt
    for (_ <- 1 to k) {
      var j = 0
      while (v > 0) {
        j += v % 10
        v /= 10
      }
      v = j
    }
    v
  }
  def main(args: Array[String]) {
    if (alphabetindexdigitsum("abc", 1) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("az", 2) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("cat", 1) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("dog", 2) == 8) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("perl", 3) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
