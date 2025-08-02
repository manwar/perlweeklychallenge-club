import scala.collection.mutable

object Oddletters {
  def counterify(a: List[Char]): Map[Char, Int] = {
    var cc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }

  def oddletters(a: String): Boolean = {
    val c = counterify(a.toCharArray.toList);
    c.values.forall(_ % 2 == 1)
  }

  def main(args: Array[String]) {
    if (!oddletters("weekly")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (oddletters("perl")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!oddletters("challenge")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
