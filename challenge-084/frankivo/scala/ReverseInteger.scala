import scala.util.Try

object ReverseInteger {
  val examples = Seq(1234, -1234, 1231230512)

  def main(args: Array[String]): Unit = {
    examples
      .map(reverse)
      .foreach(println)
  }

  def reverse(n: Int): Int = {
    val dropN = if (n < 0) 1 else 0
    val multiplier = if (n < 0) -1 else 1
    Try(n.toString.drop(dropN).reverse.toInt * multiplier).getOrElse(0)
  }
}