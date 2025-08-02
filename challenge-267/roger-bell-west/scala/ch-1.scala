
object Productsign {
  def productsign(a: List[Int]): Int = {
    var out = 1
    for (t <- a) {
      if (t < 0) {
        out = -out
      } else if (t == 0) {
        out = 0
      }
    }
    out
  }
  def main(args: Array[String]) {
    if (productsign(List(-1, -2, -3, -4, 3, 2, 1)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (productsign(List(1, 2, 0, -2, -1)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (productsign(List(-1, -1, 1, -1, 2)) == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
