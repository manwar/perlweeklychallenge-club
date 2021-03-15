object tripletSum extends App {
  val tests = List(1.2, 0.4, 0.1, 2.5)
  var found = false
  for (comb <- tests.combinations(3)) {
    val sum = comb.sum
    if (sum > 1 && sum < 2)
      println(comb.mkString(" "))
    found = true
  }
  if (found) {
    println(1)
  } else {
    println(0)
  }
}
