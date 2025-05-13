import scala.collection.mutable.ListBuffer

object Backspacecompare {
  def backspacecompare(a: String, b: String): Boolean = {
    var sa = new ListBuffer[String]
    for (i <- List(a, b)) {
      var oa = new ListBuffer[Char]
      i.toCharArray.foreach(c => {
        if (c == '#') {
          oa = oa.dropRight(1)
        } else {
          oa += c
        }
      })
      sa += oa.toString
    }
    sa(0) == sa(1)
  }
  def main(args: Array[String]) {
    if (backspacecompare("ab#c", "ad#c")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (backspacecompare("ab##", "a#b#")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!backspacecompare("a#b", "c")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
