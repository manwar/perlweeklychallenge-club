import scala.collection.mutable

object Luckyinteger {
  def luckyinteger(a: List[Int]): Int = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (p <- a) {
      c += (p -> (c(p) + 1))
    }
    var c1 = c.values.toList.sortWith(_ > _);
    var c2 = c.keys.toList.sortWith(_ > _);
    var ret = -1;
    for (v1 <- c1) {
      for (v2 <- c2) {
        if (ret == -1 && c(v2) == v1 && v1 == v2) {
          ret = v2
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (luckyinteger(List(2, 2, 3, 4)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (luckyinteger(List(1, 2, 2, 3, 3, 3)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (luckyinteger(List(1, 1, 1, 3)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
