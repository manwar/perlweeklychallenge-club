
object Formatstring {
  def formatstring(a: String, n: Int): String = {
    val p = a.toCharArray.filter{x => x != '-'}
    var r = p.size % n
    if (r == 0) {
      r += n
    }
    var o =new String
    for ((c, i) <- p.zipWithIndex) {
      if (r == i) {
        o += '-'
        r += n
      }
      o += c
    }
    o
  }
  def main(args: Array[String]) {
    if (formatstring("ABC-D-E-F", 3) == "ABC-DEF") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatstring("A-BC-D-E", 2) == "A-BC-DE") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatstring("-A-B-CD-E", 4) == "A-BCDE") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
