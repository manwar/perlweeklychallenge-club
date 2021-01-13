object WordCount {

  def main(args: Array[String]): Unit = {
    println(getCounts("WestSideStory.txt"))
  }

  def getCounts(filename: String): String = {
    scala.io.Source.fromFile(filename)
      .getLines
      .mkString(" ")
      .replaceAll("(\\.|\"|\\(|\\)|,|'s|--)", "")
      .split(" ")
      .filter(_.length > 0)
      .groupMapReduce(identity)(_ => 1)(_ + _)
      .groupBy(c => c._2)
      .map(x => (x._1, x._2.keys))
      .toList
      .sortBy(_._1)
      .map(x => s"${x._1} ${x._2.mkString(" ")}")
      .mkString("\n\n")
  }
}