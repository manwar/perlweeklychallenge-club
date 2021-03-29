object root extends App {
  val in: Int = if (args.size == 1) args(0).toInt else 248832
  for (i <- 1 to 10) {
    val root = scala.math.pow(in, (1 / i.toDouble))
    println(f"$i%2d $root%10.3f")
  }
}
