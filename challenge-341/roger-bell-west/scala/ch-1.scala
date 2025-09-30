import scala.collection.mutable

object Brokenkeyboard {
  def brokenkeyboard(a: String, b: List[String]): Int = {
    val bk = b.map( x => x.toLowerCase.toList(0) ).toSet
    var ct = 0
    for (w <- a.split(" ")) {
      val nl = w.toLowerCase.toSet
      if ((bk & nl).size == 0) {
        ct += 1
      }
    }
    ct
  }
  def main(args: Array[String]) {
    if (brokenkeyboard("Hello World", List("d")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeyboard("apple banana cherry", List("a", "e")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeyboard("Coding is fun", List()) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeyboard("The Weekly Challenge", List("a", "b")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeyboard("Perl and Python", List("p")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
