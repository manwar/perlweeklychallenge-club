import scala.collection.mutable.ListBuffer

object Decodexor {
  def decodexor(a: List[Int], nit: Int): List[Int] = {
    var out = new ListBuffer[Int]
    out += nit
    for (v <- a) {
      out += (out(out.size - 1) ^ v)
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (decodexor(List(1, 2, 3), 1) == List(1, 0, 2, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (decodexor(List(6, 2, 7, 3), 4) == List(4, 2, 0, 7, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}