import scala.collection.mutable

object Digitcountvalue {
  def digitcountvalue(a: List[Int]): Boolean = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (p <- a) {
      c += (p -> (c(p) + 1))
    }
    var ret = true
    for (ix <- 0 until a.size) {
      if (a(ix) != c(ix)) {
        ret = false
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (digitcountvalue(List(1, 2, 1, 0))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!digitcountvalue(List(0, 3, 0))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
