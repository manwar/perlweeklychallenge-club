object Sequencer {
  def sequencer(n: Int): Int = {
    (0 to (n / 3))
      .map(x => (1 to 3).map(y => y + x * 10))
      .flatten
      .toSeq(n)
  }
}