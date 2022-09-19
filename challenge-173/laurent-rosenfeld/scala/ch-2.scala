object sylvester extends App {
  var n = BigInt(2)
  println(n)
  for (i <- 1 to 9) {
    n = n * (n - 1) + 1
    println(n)
  }
}
