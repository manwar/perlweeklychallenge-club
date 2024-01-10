
object Concatenationvalue {
  def concat(a0: Int, b0: Int): Int = {
    if (b0 == 0) {
      return 10 * a0
    }
    var a = a0
    var b = b0
    while (b > 0) {
      a *= 10
      b /= 10
    }
    return a + b0
  }

  def concatenationvalue(a: List[Int]): Int = {
    var t = 0
    for (i <- 0 to (a.length - 1) / 2) {
      val j = a.length - 1 - i
      if (j == i) {
        t += a(i)
      } else {
        t += concat(a(i), a(j))
      }
    }
    return t
  }
  def main(args: Array[String]) {
    if (concatenationvalue(List(6, 12, 25, 1)) == 1286) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (concatenationvalue(List(10, 7, 31, 5, 2, 2)) == 489) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (concatenationvalue(List(1, 2, 10)) == 112) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
