
object Subsequence {
  def subsequence(a: String, b: String): Boolean = {
    var l = a
    var s = b
    if (a.length < b.length) {
      l = b
      s = a
    }
    val st = s.toCharArray
    var si = 0
    var ret = false
    for (c <- l.toCharArray) {
      if (!ret && c == st(si)) {
        si += 1
        if (si >= st.size) {
          ret = true
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (subsequence("uvw", "bcudvew")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!subsequence("aec", "abcde")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (subsequence("sip", "javascript")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
