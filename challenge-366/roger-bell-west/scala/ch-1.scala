
object Countprefixes {
  def countprefixes(a: List[String], b: String): Int = {
    a.filter(x => b.startsWith(x)).size
  }
  def main(args: Array[String]) {
    if (countprefixes(List("a", "ap", "app", "apple", "banana"), "apple") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countprefixes(List("cat", "dog", "fish"), "bird") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countprefixes(List("hello", "he", "hell", "heaven", "he"), "hello") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countprefixes(List("", "code", "coding", "cod"), "coding") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countprefixes(List("p", "pr", "pro", "prog", "progr", "progra", "program"), "program") == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
