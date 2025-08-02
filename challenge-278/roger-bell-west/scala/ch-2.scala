import scala.collection.mutable.ListBuffer

object Reverseword {
  def reverseword(a: String, c: Char): String = {
    val m = a.indexOf(c)
    if (m == -1) {
      a
    } else {
      var b = a.slice(0, m + 1).split("").to[ListBuffer]
      b = b.sortWith(_ < _)
      b ++= a.slice(m + 1, a.length).split("")
      b.mkString("")
    }
  }
  def main(args: Array[String]) {
    if (reverseword("challenge", 'e') == "acehllnge") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseword("programming", 'a') == "agoprrmming") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseword("champion", 'b') == "champion") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
