import scala.collection.mutable

object Distinctaverage {
  def distinctaverage(a0: List[Int]): Int = {
    val a = a0.sortWith(_ < _)
    val offset = a.size - 1
    val limit = a.size / 2
    var res = mutable.Set.empty[Int]
    for (i <- 0 to limit - 1) {
      res += (a(i) + a(offset - i))
    }
    res.size
  }
  def main(args: Array[String]) {
    if (distinctaverage(List(1, 2, 4, 3, 5, 6)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (distinctaverage(List(0, 2, 4, 8, 3, 5)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (distinctaverage(List(7, 3, 1, 0, 5, 9)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
