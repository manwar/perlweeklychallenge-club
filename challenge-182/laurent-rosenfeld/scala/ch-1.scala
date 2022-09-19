object fraction_tree extends App {

  val tests: List[List[Int]] =
    List(List(5, 2, 9, 1, 7, 6), List(4, 2, 3, 1, 5, 0))
  for (test <- tests) {
    var max_i = 0
    var max_n = test(max_i)
    for (i <- 1 to test.length - 1) {
      if (test(i) > max_n) {
        max_n = test(i)
        max_i = i
      }
    }
    println("Max index for " + test.mkString(" ") + s": $max_i => $max_n")
  }
}
