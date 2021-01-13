import Array._
object Main {
  def main(args: Array[String]): Unit = {
    var mat = range(1, 10)
    var in = Array.empty[Int]
    permute(in, mat)
  }
  def print_matrix(a: Array[Int]): Unit = {
    println(s"[ ${a(0)} ${a(1)} ${a(2)} ]")
    println(s"[ ${a(3)} ${a(4)} ${a(5)} ]")
    println(s"[ ${a(6)} ${a(7)} ${a(8)} ]")
    println(" ")
  }
  def permute(in: Array[Int], left: Array[Int]): Unit = {
    val sum = 15
    if (left.size == 0) {
      if (
        in.slice(0, 3).sum != sum ||
        in.slice(3, 6).sum != sum ||
        in.slice(6, 9).sum != sum ||
        in(0) + in(3) + in(6) != sum ||
        in(1) + in(4) + in(7) != sum ||
        in(2) + in(5) + in(8) != sum ||
        in(0) + in(4) + in(8) != sum ||
        in(2) + in(4) + in(6) != sum
      ) {
        return
      }
      print_matrix(in)
      return
    }
    for (candidate <- left) {
      val values: Array[Int] = in.appended(candidate)
      val newleft: Array[Int] = left.filter(_ != candidate)
      permute(values, newleft)
    }
  }
}
