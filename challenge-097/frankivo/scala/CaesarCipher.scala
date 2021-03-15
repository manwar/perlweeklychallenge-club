object CaesarCipher {
  val examples = Seq(
    "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  )

  def main(args: Array[String]): Unit = {
   examples
    .map(cipher(_, 3))
    .foreach(println)
  }

  /*
   * Simple cipher solution.
   * Will break if input is not upper case (or otherwise unexpected).
  */
  def cipher(S: String, N: Int): String = {
    val abc = 'A' to 'Z'

    S.map(c => c.toInt - 65)
      .map(_ - N)
      .map(c => if (c < 0) abc.length +c else c)
      .map(c => if(c < 0) " " else abc(c))
      .mkString
  }
}