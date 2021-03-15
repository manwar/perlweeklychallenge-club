object caesar extends App {
  val test = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"
  val shift = 3
  println( test.map(convert(_, shift)))

  def convert(c: Char, shift: Int): Char = {
    val min = 'A'.toByte
    val asc = c.toByte - shift;
    val conv = if (asc < min) asc + 26 else asc
    return if (c == ' ') ' ' else conv.toChar
  }
}
