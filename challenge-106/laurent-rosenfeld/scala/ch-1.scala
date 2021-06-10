object root extends App {
  val tests = Seq(2, 9, 3, 5)
  val sorted = tests.sorted
  val max = if (sorted.size <= 1) 0 else
    (1 to sorted.length - 1).map(i => sorted(i) - sorted(i - 1)).max
  println("Max gap is: " + max)
}
