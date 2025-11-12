import scala.util.matching.Regex

object Formatdate {
  def formatdate(a: String): String = {
    val re: Regex = "^([0-9]+)[a-z]+ ([A-Z][a-z]{2}) ([0-9]+)".r
    var out = ""
    val mr = a match {
      case re(dt, mt, yt) => {
        val d = dt.toInt
        val mm = List(
          "Jan" -> 1,
          "Feb" -> 2,
          "Mar" -> 3,
          "Apr" -> 4,
          "May" -> 5,
          "Jun" -> 6,
          "Jul" -> 7,
          "Aug" -> 8,
          "Sep" -> 9,
          "Oct" -> 10,
          "Nov" -> 11,
          "Dec" -> 12
        ).toMap
        val m = mm(mt)
        val y = yt.toInt
        out = "%04d-%02d-%02d".format(y, m, d)
      }
    }
    out
  }
  def main(args: Array[String]) {
    if (formatdate("1st Jan 2025") == "2025-01-01") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatdate("22nd Feb 2025") == "2025-02-22") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatdate("15th Apr 2025") == "2025-04-15") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatdate("23rd Oct 2025") == "2025-10-23") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatdate("31st Dec 2025") == "2025-12-31") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
