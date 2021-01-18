object Main {
  def main(args: Array[String]): Unit = {
    val num = args(0).toString
    if (num == num.reverse) {
      println(1)
    } else {
      println(0)
    }
  }
}
