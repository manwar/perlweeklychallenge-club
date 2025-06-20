import scala.collection.mutable.ListBuffer

object Decompressedlist {
  def decompressedlist(a: List[Int]): List[Int] = {
    var out = new ListBuffer[Int]
    for (i <- a.grouped(2)) {
      for (n <- 1 to i(0)) {
        out += (i(1))
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (decompressedlist(List(1, 3, 2, 4)) == List(3, 4, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decompressedlist(List(1, 1, 2, 2)) == List(1, 2, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decompressedlist(List(3, 1, 3, 2)) == List(1, 1, 1, 2, 2, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
