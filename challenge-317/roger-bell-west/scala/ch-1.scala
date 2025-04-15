import scala.collection.mutable.ListBuffer

object Acronyms {
  def acronyms(a: List[String], b: String): Boolean = {
    var os = new ListBuffer[Char]
    for (c <- a) {
      os += c.charAt(0)
    }
    os.mkString("") == b
  }
  def main(args: Array[String]) {
    if (acronyms(List("Perl", "Weekly", "Challenge"), "PWC")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (acronyms(List("Bob", "Charlie", "Joe"), "BCJ")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!acronyms(List("Morning", "Good"), "MM")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
