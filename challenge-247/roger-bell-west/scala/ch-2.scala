import scala.collection.mutable

object Mostfrequentletterpair {
  def mostfrequentletterpair(s: String): String = {
    var f = mutable.Map.empty[String, Int]
    for ( i <- 0 until s.length - 1 ) {
      val ss = s.substring(i, i + 2)
      var nv = 1
      if (f.contains(ss)) {
        nv = 1 + f(ss)
      }
      f += (ss -> nv)
    }
    val m = f.values.max
    val l = f.keys.filter(i => f(i) == m).toList.sortWith(_ < _)
    return l(0)
  }
  def main(args: Array[String]) {
      if (mostfrequentletterpair("abcdbca") == "bc") {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (mostfrequentletterpair("cdeabeabfcdfabgcd") == "ab") {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
