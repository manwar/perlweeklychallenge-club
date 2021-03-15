

object pairDiff extends App {
  val target = 7
  val test = List(10, 8, 12, 15, 5)
  var found = 0
  for (i <- 0 to test.length - 1) {
 
    for (j <- i to test.length - 1) {
      if ((test(i) - test(j)).abs == target) found = 1
    }
  }
  println(found)
}

