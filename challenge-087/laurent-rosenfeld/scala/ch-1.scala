object longestSeq extends App {
  val in = Seq(100, 4, 50, 3, 2)
  val sorted = in.sorted
  var sequences = Array.empty[Array[Int]]
  var lastEl = sorted(0)
  var oneSeq = Array(lastEl)
  for (current <- sorted.tail) {
    if (current != lastEl + 1) {
      sequences :+= oneSeq
      oneSeq = Array(current)
    } else {
      oneSeq :+= current
    }
    lastEl = current
  }
  sequences = sequences :+ oneSeq
  val sortedSeq = sequences.sortWith(_.size > _.size)
  if (sortedSeq(0).size > 1) {
    println(sortedSeq(0).mkString(" "))
  } else {
    println(0)
  }
}

/*
2 3 4
*/