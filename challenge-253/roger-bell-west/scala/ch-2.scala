import scala.collection.mutable.ListBuffer

object Weakestrows {
  def weakestrows(a: List[List[Int]]): List[Int] = {
    var p = List.range(0, a.size).to[ListBuffer]
    val b = a.map(n => n.sum)
    p = p.sortWith(b(_) < b(_))
    return p.toList
  }
  def main(args: Array[String]) {
    if (weakestrows(List(List(1, 1, 0, 0, 0), List(1, 1, 1, 1, 0), List(1, 0, 0, 0, 0), List(1, 1, 0, 0, 0), List(1, 1, 1, 1, 1))) == List(2, 0, 3, 1, 4)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (weakestrows(List(List(1, 0, 0, 0), List(1, 1, 1, 1), List(1, 0, 0, 0), List(1, 0, 0, 0))) == List(0, 2, 3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
