object sparkLine extends App {

  def sparkline(test: Array[Int]): String = {
    val bars = ('\u2581' to '\u2588')
    var outl = ""
    for (item <- test) {
      var h = bars.length * (item - test.min) / (test.max - test.min)
      if (h >= bars.length) { h = bars.length - 1 }
      outl = outl + bars(h)
    }
    return outl
  }
  val tests = Array(
    Array(1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1),
    Array(0, 1, 19, 20),
    Array(0, 999, 4000, 4999, 7000, 7999)
  )
  for (test <- tests) {
    println(test.mkString(" "))
    println("")
    println(sparkline(test))
    println("")
  }
}
