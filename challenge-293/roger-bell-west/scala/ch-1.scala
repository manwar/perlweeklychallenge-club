import scala.collection.mutable

object Similardominoes {
  def counterify(a: List[Int]): Map[Int, Int] = {
    var cc = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }
  def dvalue(a: List[Int]): Int = {
    var ret = 0
    if (a(0) < a(1)) {
      ret = a(0) * 64 + a(1)
    } else {
      ret = a(1) * 64 + a(0)
    }
    ret
  }
  def similardominoes(a: List[List[Int]]): Int = {
    val c = counterify(a.map(x => dvalue(x)))
    var t = 0
    for (v <- c.values) {
      if (v > 1) {
        t += v
      }
    }
    return t
  }
  def main(args: Array[String]) {
    if (similardominoes(List(List(1, 3), List(3, 1), List(2, 4), List(6, 8))) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (similardominoes(List(List(1, 2), List(2, 1), List(1, 1), List(1, 2), List(2, 2))) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
