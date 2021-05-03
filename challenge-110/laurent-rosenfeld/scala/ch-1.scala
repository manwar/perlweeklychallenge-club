import scala.util.matching.Regex

object phoneNumber extends App {
  val pattern = "((?:\\d{4}|\\+\\d\\d|\\(\\d\\d\\))\\s+\\d{10})".r
  val tests = Array(
    " 0044 1148820341 42 ",
    "  +44 1148820342 abc",
    " 44-11-4882-0343 ",
    " (44) 1148820344  (33) 1148820345",
    " 00 1148820346"
  );
  for (str <- tests) {
    if (pattern.unanchored.matches(str)) {
      println((pattern findAllIn str).mkString(", "))
    }
  }
}
