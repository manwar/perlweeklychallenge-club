import scala.collection.mutable.ListBuffer

object Targetarray {
  def targetarray(a: List[Int], indices: List[Int]): List[Int] = {
    var c = new ListBuffer[Int]
    for ((ix, i) <- indices.zipWithIndex) {
      if (ix == c.size) {
        c += a(i)
      } else {
        c.insert(ix, a(i))
      }
    }
    c.toList
  }
  def main(args: Array[String]) {
      if (targetarray(List(0, 1, 2, 3, 4), List(0, 1, 2, 2, 1)) == List(0, 4, 1, 3, 2)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (targetarray(List(1, 2, 3, 4, 0), List(0, 1, 2, 3, 0)) == List(0, 1, 2, 3, 4)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (targetarray(List(1), List(0)) == List(1)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
