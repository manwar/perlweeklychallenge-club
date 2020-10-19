object WordsLength {
    val examples: Seq[String] = Seq(
        "The Weekly Challenge",
        "The purpose of our lives is to be happy"
    )
    
    def main(args: Array[String]): Unit = {
       examples
        .map(e => (e, count(e)))
        .foreach(println)
    }

    def count(line: String) : Int = {
        line.split(" ")
            .drop(1)
            .dropRight(1)
            .mkString
            .length
    }
}