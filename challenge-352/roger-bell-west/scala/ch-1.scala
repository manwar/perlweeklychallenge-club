import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Matchstring {
  def matchstring(a: List[String]): List[String] = {
    var out = new ListBuffer[String]
    for (x <- a) {
      if (!out.contains(x)) {
        for (y <- a) {
          if (!out.contains(x)) {
            if (y.length > x.length && y.indexOf(x) >= 0) {
              out += x
            }
          }
        }
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (matchstring(List("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")) == List("cat", "dog", "dogcat", "rat")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (matchstring(List("hello", "hell", "world", "wor", "ellow", "elloworld")) == List("hell", "world", "wor", "ellow")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (matchstring(List("a", "aa", "aaa", "aaaa")) == List("a", "aa", "aaa")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (matchstring(List("flower", "flow", "flight", "fl", "fli", "ig", "ght")) == List("flow", "fl", "fli", "ig", "ght")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (matchstring(List("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")) == List("car", "pet", "enter", "pen", "pent")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
