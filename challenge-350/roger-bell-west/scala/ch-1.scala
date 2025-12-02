import scala.collection.mutable

object Goodsubstrings {
  def counterify(a: List[Char]): Map[Char, Int] = {
    var cc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }
  
  def goodsubstrings(a: String): Int = {
    var p = 0
    for (s <- a.toList.sliding(3)) {
      val c = counterify(s)
      if (c.values.max == 1) {
        p += 1
      }
    }
    p
  }

  def main(args: Array[String]) {
    if (goodsubstrings("abcaefg") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goodsubstrings("xyzzabc") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goodsubstrings("aababc") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goodsubstrings("qwerty") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (goodsubstrings("zzzaaa") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
