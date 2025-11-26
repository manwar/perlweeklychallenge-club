import scala.collection.mutable

object Meetingpoint {
  def counterify(a: List[Char]): Map[Char, Int] = {
    var cc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }

  def meetingpoint(a: String): Boolean = {
    val c = counterify(a.toList)
    (c.get('U') getOrElse 0) == (c.get('D') getOrElse 0) &&
    (c.get('L') getOrElse 0) == (c.get('R') getOrElse 0)
  }

  def main(args: Array[String]) {
    if (!meetingpoint("ULD")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (meetingpoint("ULDR")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!meetingpoint("UUURRRDDD")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (meetingpoint("UURRRDDLLL")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!meetingpoint("RRUULLDDRRUU")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
