import scala.collection.mutable.ListBuffer

object Equalstrings {
  def equalstrings(a: List[String]): Int = {
    val ax = a.toSet
    var ca = new ListBuffer[List[Char]]
    for (x <- ax) {
      ca += x.toList
    }
    val mmlen = ca.map(x => x.size ).min
    var si = 0
    var ret = 0;
    for (i <- 0 until mmlen) {
      si = i
      var b = false
      var s = 1
      while (!b && s < ca.size) {
        if (ca(0)(i) != ca(s)(i)) {
          if (i == 0) {
            ret = -1
          }
          si -= 1
          b = true
        }
        s += 1
      }
    }
    if (ret == 0) {
      ret = a.map(x => x.size ).sum - a.size * (si + 1)
    }
    ret
  }
  def main(args: Array[String]) {
    if (equalstrings(List("abc", "abb", "ab")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (equalstrings(List("ayz", "cyz", "xyz")) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (equalstrings(List("yza", "yzb", "yzc")) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
