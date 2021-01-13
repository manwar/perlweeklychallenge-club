object ArrayOfProduct extends App {
  val in = Array(5, 2, 1, 4, 3)
  var product = 1;
  for (item <- in) {
    product *= item;
  }
  val result = in.map(product / _)
  println(result.mkString(" "));
}
// prints: 24 60 120 30 40