import scala.collection.mutable

object Equalgroup {
  def counterify(a: List[Int]): Map[Int, Int] = {
    var cc = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }
  def equalgroup(a: List[Int]): Boolean = {
    val s = counterify(a)
    val v = s.values.toSet.toList.sortWith(_ < _)
    val l = v(0)
    var ret = false
    if (l >= 2) {
      for (t <- 2 to l) {
        if (!ret && v.forall(_ % t == 0)) {
          ret = true
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (equalgroup(List(1, 1, 2, 2, 2, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!equalgroup(List(1, 1, 1, 2, 2, 2, 3, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (equalgroup(List(5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!equalgroup(List(1, 2, 3, 4))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (equalgroup(List(8, 8, 9, 9, 10, 10, 11, 11))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
