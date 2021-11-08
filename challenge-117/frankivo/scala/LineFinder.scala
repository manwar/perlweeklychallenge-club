object LineFinder {
  val input =
    """
      |11, Line Eleven
      |1, Line one
      |9, Line Nine
      |13, Line Thirteen
      |2, Line two
      |6, Line Six
      |8, Line Eight
      |10, Line Ten
      |7, Line Seven
      |4, Line Four
      |14, Line Fourteen
      |3, Line three
      |15, Line Fifteen
      |5, Line Five
      |""".stripMargin

  def getLineNumbers: Seq[Int] = input
    .split("\n")
    .drop(1)
    .map(_.split(","))
    .map(_ (0))
    .map(_.toInt)

  def main(args: Array[String]): Unit = {
    val lineNumbers = getLineNumbers

    (1 to (lineNumbers.max))
      .diff(lineNumbers)
      .foreach(println)
  }
}
