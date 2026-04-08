import scala.collection.mutable.ListBuffer

object Makeitbigger {
  def makeitbigger(st: String, ch: String): String = {
    var i = 0
    var nv = new ListBuffer[Int]
    var c = st.indexOf(ch, i)
    while (c > -1) {
      var o = ""
      if (c > 0) {
        o = o + st.slice(0, c)
      }
      if (c < st.length) {
        o = o + st.slice(c + 1, st.length)
      }
      nv += o.toInt
      i = c + 1
      c = st.indexOf(ch, i)
    }
    return nv.max.toString
  }
  def main(args: Array[String]) {
    if (makeitbigger("15456", "5") == "1546") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (makeitbigger("7332", "3") == "732") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (makeitbigger("2231", "2") == "231") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (makeitbigger("543251", "5") == "54321") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (makeitbigger("1921", "1") == "921") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
