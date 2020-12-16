import Array._
object numCount extends App {
  val tests = List("1122234", "2333445", "12345")
  for (test <- tests) {
    println(f"$test%-10s -> ${countNumbers(test)}%s")
  }

  def countNumbers(n: String): String = {
    var result = ""
    val digits = n.split("")
    var start = digits(0)
    var count = 1
    for (i <- 1 to digits.size - 1) {
      if (digits(i).equals(start)) {
        count += 1
      } else {
        result += s"$count" + start
        count = 1;
        start = digits(i)
      }
    }
    result += s"$count" + start
    return result
  }
}
