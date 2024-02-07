import scala.collection.mutable

object Oddcharacter {
  def oddcharacter(s: String, t: String): Char = {
    var ss = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (c <- s.toList) {
      ss += (c -> (ss(c) + 1))
    }
    for (c <- t.toList) {
      if (ss(c) > 0) {
        ss += (c -> (ss(c) - 1))
      } else {
        return c
      }
    }
    return '@'
  }
  def main(args: Array[String]) {
    if (oddcharacter("Perl", "Preel") == 'e') {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddcharacter("Weekly", "Weeakly") == 'a') {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddcharacter("Box", "Boxy") == 'y') {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
