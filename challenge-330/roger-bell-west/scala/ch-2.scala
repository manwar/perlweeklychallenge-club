
import scala.collection.mutable.ListBuffer

object Titlecapital {
  def titlecapital(a: String): String = {
    var out = new ListBuffer[String]
    for (w <- a.split(" ")) {
      var p = w.toLowerCase()
      if (p.length > 2) {
        var c = p.to[ListBuffer]
        c(0) = c(0).toUpper
        p = c.mkString
      }
      out += p
    }
    out.mkString(" ")
  }
  def main(args: Array[String]) {
    if (titlecapital("PERL IS gREAT") == "Perl is Great") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (titlecapital("THE weekly challenge") == "The Weekly Challenge") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (titlecapital("YoU ARE A stAR") == "You Are a Star") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
