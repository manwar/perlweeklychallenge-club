import scala.collection.mutable.ListBuffer

object Duplicateremovals {
  def duplicateremovals(a: String): String = {
    var b = new ListBuffer[Char]
    for (c <- a.toList) {
      if (b.size == 0 || c != b(b.size - 1)) {
        b += c
      } else {
        b = b.dropRight(1)
      }
    }
    b.mkString
  }
  def main(args: Array[String]) {
    if (duplicateremovals("abbaca") == "ca") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicateremovals("azxxzy") == "ay") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicateremovals("aaaaaaaa") == "") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicateremovals("aabccba") == "a") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicateremovals("abcddcba") == "") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
