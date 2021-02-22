object SearchInsertPosition {

    val examples = Seq(
        (Seq(1, 2, 3, 4), 3),
        (Seq(1, 3, 5, 7), 6),
        (Seq(12, 14, 16, 18), 10),
        (Seq(11, 13, 15, 17), 19)
    )

    def searchIndex(A: Seq[Int], N: Int) : Int = (A :+ N).indexWhere(_ >= N)

    def main(args: Array[String]): Unit = {
        examples
        .map(e => (e, searchIndex(e._1, e._2)))
        .foreach(i => {
            println(s"A: ${i._1._1}, N: ${i._1._2}, O: ${i._2}")
        })
    }
}