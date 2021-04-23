object bellNum extends App {
  val max = 10
  var tr = Array.ofDim[Int](max, max)
  tr(0)(0) = 1
  for (row <- 1 until max) {
    tr(row)(0) = tr(row - 1)(row - 1)
    for (i <- 1 until row + 1) {
      tr(row)(i) = tr(row)(i - 1) + tr(row - 1)(i - 1)
    }
  }
  val result = for (i <- 0 until max) yield tr(i)(0)
  println (s"Bell numbers: ${result.mkString(" ")}")
}
