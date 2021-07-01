object Sequencer {
  def sequencer(n: Int): Int = {
    var i = 1
    var ok = 1
    while (ok < n) {
      if (!i.toString.exists(((4 to 9).toSeq :+ 0).map(_.toString) contains _.toString))
        if (!i.toString.contains("11"))
          ok = ok + 1
      i = i + 1
    }
    i
  }
}