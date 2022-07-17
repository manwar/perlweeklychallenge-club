object esthetic extends App {
  def is_esthetic(num: Int): Boolean = {
    val digits = num.toString.split("")
    for (i <- 1 to (digits.size) - 1) {
      if ((digits(i).toInt - digits(i-1).toInt).abs != 1) {
        return false
      }
    }
    return true
  }
  val tests = List(5456, 120, 121, 23456, 2346, 7654567, 765467)
  for (test <- tests) {
    if (is_esthetic(test)) {
      println(s"$test is esthetic")
    } else {
      println(s"$test is not esthetic")
    }
  }
}
