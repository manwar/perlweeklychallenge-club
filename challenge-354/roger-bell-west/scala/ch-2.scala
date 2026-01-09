
object Shiftgrid {
  def shiftgrid(gi: List[List[Int]], k0: Int): List[List[Int]] = {
    val wi = gi.flatten
    val k = k0 % wi.size
    val wo = wi.drop(wi.size - k) ++ wi.slice(0, wi.size - k)
    wo.grouped(gi(0).size).toList
  }
  def main(args: Array[String]) {
    if (shiftgrid(List(List(1, 2, 3), List(4, 5, 6), List(7, 8, 9)), 1) == List(List(9, 1, 2), List(3, 4, 5), List(6, 7, 8))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shiftgrid(List(List(10, 20), List(30, 40)), 1) == List(List(40, 10), List(20, 30))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shiftgrid(List(List(1, 2), List(3, 4), List(5, 6)), 1) == List(List(6, 1), List(2, 3), List(4, 5))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shiftgrid(List(List(1, 2, 3), List(4, 5, 6)), 5) == List(List(2, 3, 4), List(5, 6, 1))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shiftgrid(List(List(1, 2, 3, 4)), 1) == List(List(4, 1, 2, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
