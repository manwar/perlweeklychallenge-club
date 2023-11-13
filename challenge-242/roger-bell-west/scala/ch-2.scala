
object Flipmatrix {
  def flipmatrix(a: List[List[Int]]): List[List[Int]] = {
    return a.map(row => row.map(v => 1 - v).reverse)
  }
  def main(args: Array[String]) {
      if (flipmatrix(List(List(1, 1, 0), List(1, 0, 1), List(0, 0, 0))) == List(List(1, 0, 0), List(0, 1, 0), List(1, 1, 1))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (flipmatrix(List(List(1, 1, 0, 0), List(1, 0, 0, 1), List(0, 1, 1, 1), List(1, 0, 1, 0))) == List(List(1, 1, 0, 0), List(0, 1, 1, 0), List(0, 0, 0, 1), List(1, 0, 1, 0))) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
