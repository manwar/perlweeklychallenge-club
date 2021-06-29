object NibbleSwap {
  def swap(n: Int): Int = {
    Integer.parseInt(
      "%08d" // Two-nibble limit is here.
        .format(n.toBinaryString.toInt) // Don't really like the double cast.
        .grouped(4)
        .toArray
        .reverse
        .mkString,
      2)
  }
}
