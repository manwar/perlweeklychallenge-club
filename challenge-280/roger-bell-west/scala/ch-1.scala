import scala.collection.mutable

object Twiceappearance {
  def twiceappearance(a: String): Char = {
    var m = mutable.Set.empty[Char]
    var ex = false
    var out = 'x'
    for (c <- a.toList) {
      if (!ex) {
        if (m.contains(c)) {
          out = c
          ex = true
        } else {
          m += c
        }
      }
    }
    return out
  }
  def main(args: Array[String]) {
    if (twiceappearance("acbddbca") == 'd') {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (twiceappearance("abccd") == 'c') {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (twiceappearance("abcdabbb") == 'a') {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
