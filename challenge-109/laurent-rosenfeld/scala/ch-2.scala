object fourSquares extends App {
  val in = (1 to 7).toList
  for (perm <- in.permutations) {
    val sum = perm.slice(0, 2).sum;
        // In Scala, slice(0, 2) returns items 0 and 1
    if (
      perm.slice(1, 4).sum == sum &&
      perm.slice(3, 6).sum == sum &&
      perm.slice(5, 7).sum == sum
    ) {
      println(perm.mkString(" "))
    }
  }
}
