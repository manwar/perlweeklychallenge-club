import Array._
object jumpGame extends App {
  val tests =
    Array(Array(1, 2, 1, 2), Array(2, 1, 1, 0, 2), Array(1, 2, 1, 2, 1))
  for (test <- tests) {
    println(s"${test.mkString(" ")} -> ${jump(test)}")
  }

  def jump(in: Array[Int]): Int = {
    var i = 0;
    val max = in.size - 1
    while (i <= max) {
      if (in(i) == 0) { return 0 }
      val next_i = i + in(i);
      if (next_i == max) { return 1 }
      if (next_i > max) { return 0 }
      i = next_i;
    }
    return 0
  }
}
