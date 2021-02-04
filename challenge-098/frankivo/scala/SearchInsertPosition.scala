case class Example(A: Seq[Int], N: Int, E: Int)

object SearchInsertPosition {

    val examples = Seq(
        Example(Seq(1, 2, 3, 4), 3, 2),
        Example(Seq(1, 3, 5, 7), 6, 3),
        Example(Seq(12, 14, 16, 18), 10, 0),
        Example(Seq(11, 13, 15, 17), 19, 4)
    )

    def searchIndex(A: Seq[Int], N: Int) : Int = (A :+ N).indexWhere(_ >= N)

    def main(args: Array[String]): Unit = {
        examples
        .map(e => searchIndex(e.A, e.N) == e.E)
        .foreach(println)
    }
}