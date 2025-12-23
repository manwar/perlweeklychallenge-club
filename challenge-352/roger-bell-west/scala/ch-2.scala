import scala.collection.mutable.ListBuffer

object Binaryprefix {
  def binaryprefix(a: List[Int]): List[Boolean] = {
    var c = 0
    var out = new ListBuffer[Boolean]
    for (n <- a) {
      c *= 2
      c += n
      out += (c % 5 == 0)
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (binaryprefix(List(0, 1, 1, 0, 0, 1, 0, 1, 1, 1)) == List(true, false, false, false, false, true, true, false, false, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryprefix(List(1, 0, 1, 0, 1, 0)) == List(false, false, true, true, false, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryprefix(List(0, 0, 1, 0, 1)) == List(true, true, false, false, true)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryprefix(List(1, 1, 1, 1, 1)) == List(false, false, false, true, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryprefix(List(1, 0, 1, 1, 0, 1, 0, 0, 1, 1)) == List(false, false, true, false, false, true, true, true, false, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
