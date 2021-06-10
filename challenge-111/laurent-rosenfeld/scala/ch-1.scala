object SearchItem extends App {
  val matrix = Array(
    Array(1, 2, 3, 5, 7),
    Array(9, 11, 15, 19, 20),
    Array(23, 24, 25, 29, 31),
    Array(32, 33, 39, 40, 42),
    Array(45, 47, 48, 49, 50)
  )

  var hash = scala.collection.mutable.Map[Int, Int]()
  for (row <- matrix) {
    for (item <- row) {
      hash(item) = 1
    }
  }

  for (i <- 0 to 54) {
    if (hash.contains(i)) {
      println(s"$i => 1")
    } else {
      println(s"$i => 0")
    }
  }
}
