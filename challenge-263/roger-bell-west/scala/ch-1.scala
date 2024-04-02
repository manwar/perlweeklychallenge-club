import scala.collection.mutable.ListBuffer

object Targetindex {
  def targetindex(a0: List[Int], k: Int): List[Int] = {
    var a = a0.sortWith(_ < _)
    var r = new ListBuffer[Int]
    for ((v, i) <- a.zipWithIndex) {
      if (v == k) {
        r += i
      }
    }
    r.toList
  }
  def main(args: Array[String]) {
    if (targetindex(List(1, 5, 3, 2, 4, 2), 2) == List(1, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (targetindex(List(1, 2, 4, 3, 5), 6) == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (targetindex(List(5, 3, 2, 4, 2, 1), 4) == List(4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
