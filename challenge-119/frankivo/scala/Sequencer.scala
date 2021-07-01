object Sequencer {
  def sequencer(n: Int): Int = {
    ((1 to n * n.toString.length * 30)
      .filterNot(_.toString exists (((4 to 9).toSeq :+ 0).map(_.toString) contains _.toString))
      .filterNot(_.toString contains "11")
      ) (n - 1)
  }
}