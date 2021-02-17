object TriangleSum {
    val examples = Seq(
        "[1], [2,4], [6,4,9], [5,1,7,2]",
        "[3], [3,1], [5,2,3], [4,3,1,3]"
    )

    // def parseExample(e: String) : Array[Array[Int]] = {
    def parseExample(e: String) : Unit = {
        e
            .split(" ")
            .map(_.replaceAll("""([\[\]])""", ""))
            .map(_.split(", ").toString)
            .foreach(println)
    }
    
    def main(args: Array[String]): Unit = {
        examples
            .take(1).map(parseExample)
            // .foreach(println)
    }
}