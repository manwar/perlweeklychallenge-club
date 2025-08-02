import scala.collection.mutable

object Greatestenglishletter {
  def greatestenglishletter(a: String): String = {
    var m = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (c <- a.toList) {
      val uc = c.toUpper
      val flag = if (c == uc) { 1 } else { 2 }
      m += (uc -> (m(uc) + flag))
    }
    val s = m.keys.filter(i => m(i) == 3).toList
    if (s.size == 0) {
      return ""
    }
    return s.sortWith(_ < _).last.toString
  }
  def main(args: Array[String]) {
    if (greatestenglishletter("PeRlwEeKLy") == "L") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (greatestenglishletter("ChaLlenge") == "L") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (greatestenglishletter("The") == "") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
