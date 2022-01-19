object dot_product extends App {
  val a1 = Array(1, 2, 3)
  val a2 = Array(4, 5, 6)
  var res = 0
  for (i <- a1.indices) {
    res = res + a1(i) * a2(i)
  }
  println("Dot product: " + res)
}
