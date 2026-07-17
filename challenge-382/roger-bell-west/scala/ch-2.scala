import scala.collection.mutable.ListBuffer

object Replacequestionmark {
  def replacequestionmark(a: String): List[String] = {
    val template = a.toList
    val q = template.filter(x => x == '?').size
    if (q == 0) {
      List(a)
    } else {
      var out = new ListBuffer[String]
      for (n <- 0 until (1 << q)) {
        var qm = new ListBuffer[Char]
        var nn = n
        while (nn > 0) {
          if (nn % 2 == 0) {
            qm += '0'
          } else {
            qm += '1'
          }
          nn /= 2
        }
        while (qm.length < q) {
          qm += '0'
        }
        var entry = ""
        for (tc <- template) {
          if (tc == '?') {
            entry += qm.last
            qm = qm.dropRight(1)
          } else {
            entry += tc
          }
        }
        out += entry
      }
      out.toList
    }
  }
  def main(args: Array[String]) {
    if (replacequestionmark("01??0") == List("01000", "01010", "01100", "01110")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (replacequestionmark("101") == List("101")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (replacequestionmark("???") == List("000", "001", "010", "011", "100", "101", "110", "111")) {
      print("Pass")
    } else {
      print("Fail")
    }
     print(" ")
    if (replacequestionmark("1?10") == List("1010", "1110")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (replacequestionmark("1?1?0") == List("10100", "10110", "11100", "11110")) {
      print("Pass")
    } else {
      print("Fail")
     }
    println("")

  }
}
