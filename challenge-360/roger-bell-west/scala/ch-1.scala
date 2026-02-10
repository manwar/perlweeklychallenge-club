import scala.collection.mutable.ListBuffer

object Textjustifier {
  def textjustifier(intxt: String, width: Int): String = {
    var working = List.fill(width)('*').to[ListBuffer]
    val offset = (width - intxt.length) / 2
    for ((c, i) <- intxt.toList.zipWithIndex) {
      working(i + offset) = c
    }
    working.mkString("")
  }
  def main(args: Array[String]) {
    if (textjustifier("Hi", 5) == "*Hi**") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (textjustifier("Code", 10) == "***Code***") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (textjustifier("Hello", 9) == "**Hello**") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (textjustifier("Perl", 4) == "Perl") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (textjustifier("A", 7) == "***A***") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (textjustifier("", 5) == "*****") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
