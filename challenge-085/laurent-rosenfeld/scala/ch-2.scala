
object powersOfInt extends App {
  val tests = List(15, 121, 144, 145, 1451)
  for (item <- tests) {
    val result = findPower(item)
    println(s"$item : $result")
  }
  def findPower(num: Int): Int = {
    if (num == 1) return 1 // trivial solution: 1**2
    for (base <- 2 to math.sqrt(num).toInt) {
      var power = 1;
      var exp = 2
      while (power <= num) {
        power = math.pow(base, exp).toInt
        if (power == num) return 1
        exp += exp
      }
    }
    return 0
  }
}

                