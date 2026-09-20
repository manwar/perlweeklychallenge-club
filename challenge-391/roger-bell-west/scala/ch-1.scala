import scala.collection.mutable.ListBuffer

object Arraymedian {
  def arraymedian(a: List[Int], b: List[Int]): Double = {
    var nn = a.to[ListBuffer]
    nn ++= b
    nn = nn.sortWith(_ < _)
    val i = nn.size / 2
    if (nn.size % 2 == 0) {
      (nn(i - 1) + nn(i)).toDouble / 2.0
    } else {
      nn(i).toDouble
    }
  }
  def main(args: Array[String]) {
    if (arraymedian(List(2), List(4)) == 3.0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arraymedian(List(1, 2, 3), List(7, 8, 9, 10)) == 7.0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arraymedian(List(), List(10, 20, 30, 40)) == 25.0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arraymedian(List(100), List(1, 2, 3, 4, 5, 6, 7)) == 4.5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arraymedian(List(1, 2, 2), List(2, 2, 3)) == 2.0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
