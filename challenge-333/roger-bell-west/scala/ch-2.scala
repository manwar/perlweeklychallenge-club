import scala.collection.mutable.ListBuffer

object Duplicatezeros {
  def duplicatezeros(a: List[Int]): List[Int] = {
    var b = new ListBuffer[Int]
    for (n <- a) {
      if (a.size > b.size) {
        b += n
        if (a.size > b.size && n == 0) {
          b += 0
        }
      }
    }
    b.toList
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
    if (duplicatezeros(List(1, 2, 3, 0)) == List(1, 2, 3, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicatezeros(List(0, 0, 1, 2)) == List(0, 0, 0, 0)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (duplicatezeros(List(1, 2, 0, 3, 4)) == List(1, 2, 0, 0, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
