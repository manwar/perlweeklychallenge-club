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
        val words = line.split(" ")

        words
            .slice(1, words.length - 1)
            .mkString
            .length
    }
}