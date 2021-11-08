object BinarySwap {
  def Swap(n: Int): Int = {
    Integer.parseInt(
      "%08d"
        .format(n.toBinaryString.toInt)
        .grouped(2)
        .map(_.reverse)
        .mkString,
      2)
  }
}