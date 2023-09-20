import scala.collection.mutable.ListBuffer

object Duplicatezeros {
  def duplicatezeros(a: List[Int]): List[Int] = {
    var out = new ListBuffer[Int]
    for (t <- a) {
      out += t
      if (t == 0) {
        out += t
      }
    }
    if (out.length > a.length) {
      out = out.dropRight(out.length - a.length)
    }
    return out.toList
  }

  def main(args: Array[String]) {
    if (duplicatezeros(List(1, 0, 2, 3, 0, 4, 5, 0)) == List(1, 0, 0, 2, 3, 0, 0, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicatezeros(List(1, 2, 3)) == List(1, 2, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicatezeros(List(0, 3, 0, 4, 5)) == List(0, 0, 3, 0, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
