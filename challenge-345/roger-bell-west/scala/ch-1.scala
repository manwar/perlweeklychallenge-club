import scala.collection.mutable.ListBuffer

object Peakpositions {
  def peakpositions(a: List[Int]): List[Int] = {
    var out = new ListBuffer[Int]
    for ((x, i) <- a.zipWithIndex) {
      if ((i == 0 || x > a(i - 1)) &&
        (i == a.size - 1 || x > a(i + 1))) {
        out += i
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (peakpositions(List(1, 3, 2)) == List(1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpositions(List(2, 4, 6, 5, 3)) == List(2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpositions(List(1, 2, 3, 2, 4, 1)) == List(2, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpositions(List(5, 3, 1)) == List(0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (peakpositions(List(1, 5, 1, 5, 1, 5, 1)) == List(1, 3, 5)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
