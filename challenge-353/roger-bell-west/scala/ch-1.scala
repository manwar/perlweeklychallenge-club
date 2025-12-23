
object Maxwords {
  def maxwords(a: List[String]): Int = {
    a.map(x => x.split(" ").size).max
  }

  def main(args: Array[String]) {
    if (maxwords(List("Hello world", "This is a test", "Perl is great")) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxwords(List("Single")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxwords(List("Short", "This sentence has six words in total", "A B C", "Just four words here")) == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxwords(List("One", "Two parts", "Three part phrase", "")) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxwords(List("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
