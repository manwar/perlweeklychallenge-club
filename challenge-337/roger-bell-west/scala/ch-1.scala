import scala.collection.mutable

object Smallerthancurrent {
  def smallerthancurrent(a: List[Int]): List[Int] = {
    val b = a.sortWith(_ < _)
    var m = mutable.Map.empty[Int, Int]
    for ((v, i) <- b.zipWithIndex) {
      if (!m.contains(v)) {
        m += ((v, i))
      }
    }
    a.map(x => m(x)).toList
  }
  def main(args: Array[String]) {
    if (smallerthancurrent(List(6, 5, 4, 8)) == List(2, 1, 0, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(7, 7, 7, 7)) == List(0, 0, 0, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(5, 4, 3, 2, 1)) == List(4, 3, 2, 1, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(-1, 0, 3, -2, 1)) == List(1, 2, 4, 0, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallerthancurrent(List(0, 1, 1, 2, 0)) == List(0, 2, 2, 4, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
