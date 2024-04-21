import scala.collection.mutable

object Thirtythreepercentappearance {
  def thirtythreepercentappearance(a: List[Int]): Int = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (n <- a) {
      c += (n -> (c(n) + 1))
    }
    var threshold = a.size * 33 / 100
    if (threshold * 100 / 33 != a.size) {
      threshold += 1
    }
    val s = c.keys.filter(i => c(i) >= threshold).toList
    if (s.size == 0) {
      return -1
    }
    return s.sortWith(_ < _)(0)
  }
  def main(args: Array[String]) {
    if (thirtythreepercentappearance(List(1, 2, 3, 3, 3, 4, 2)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thirtythreepercentappearance(List(1, 1)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (thirtythreepercentappearance(List(1, 2, 3)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
