import scala.collection.mutable

object Maximumfrequency {
  def maximumfrequency(a: List[Int]): Int = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (w <- a) {
      c += (w -> (c(w) + 1))
    }
    val mx = c.values.max
    return mx * c.values.filter(v => v == mx).size
  }
  def main(args: Array[String]) {
    if (maximumfrequency(List(1, 2, 2, 4, 1, 5)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maximumfrequency(List(1, 2, 3, 4, 5)) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
