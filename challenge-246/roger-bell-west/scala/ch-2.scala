
object Linearrecurrencesecondorder {
  def linearrecurrencesecondorder(seq: List[Int]): Boolean = {
    val a = seq.take(3)
    val b = seq.take(4).takeRight(3)
    val c = seq.take(5).takeRight(3)
    val q = (b(2) * a(0) - b(0) * a(2)) / (b(1) * a(0) - b(0) * a(1))
    val p = (a(2) - a(1) * q) / a(0)
    return p * a(0) + q * a(1) == a(2) && p * b(0) + q * b(1) == b(2) && p * c(0) + q * c(1) == c(2)
  }
  def main(args: Array[String]) {
      if (linearrecurrencesecondorder(List(1, 1, 2, 3, 5))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (!linearrecurrencesecondorder(List(4, 2, 4, 5, 7))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (linearrecurrencesecondorder(List(4, 1, 2, -3, 8))) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
