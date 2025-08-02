import scala.collection.mutable

object Uniqueoccurrences {
  def uniqueoccurrences(a: List[Int]): Int = {
    var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (n <- a) {
      c += (n -> (c(n) + 1))
    }
    var r = 0
    if (c.size == c.values.toSet.size) {
      r = 1
    }
    r
  }
  def main(args: Array[String]) {
      if (uniqueoccurrences(List(1, 2, 2, 1, 1, 3)) == 1) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (uniqueoccurrences(List(1, 2, 3)) == 0) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (uniqueoccurrences(List(-2, 0, 1, -2, 1, 1, 0, 1, -2, 9)) == 1) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
