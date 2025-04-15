import scala.collection.mutable.ListBuffer

object Friendlystrings {
  def friendlystrings(a: String, b: String): Boolean = {
    var ret = false
    for (i <- 0 until a.length - 1) {
      for (j <- i + 1 until a.length) {
        var cc = a.toCharArray()
        cc(i) = a.charAt(j)
        cc(j) = a.charAt(i)
        if (cc.mkString("") == b) {
          ret = true
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (friendlystrings("desc", "dsec")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (friendlystrings("fuck", "fcuk")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!friendlystrings("poo", "eop")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (friendlystrings("stripe", "sprite")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
