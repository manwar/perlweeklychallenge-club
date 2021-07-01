object Sequencer {
  def sequencer(n: Int): Int = {
    LazyList
      .iterate(1)(_ + 1)
      .filterNot(_.toString exists (((4 to 9).toSeq :+ 0).map(_.toString) contains _.toString))
      .filterNot(_.toString contains "11")
      .take(n)
      .last
  }
}