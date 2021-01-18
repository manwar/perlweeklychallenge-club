

object reverseInt extends App {
  val max: Long = (math.pow(2, 31) - 1).toLong
  val tests = List(1234, 678, -12, 432, 1147483647)
  for (item <- tests) {
    val result = flip(item)
    println(s"$item : $result")
  }
  def flip(input: Int): Int = {
    val negative = if (input < 0) true else false
    val in = input.abs
    val flipped = in.toString.reverse;
    if (negative) {
      if (flipped.toLong > max + 1) return 0
      return -1 * flipped.toInt
    } else {
      if (flipped.toLong > max) return 0
      return flipped.toInt
    }

  }
}

/*
1234 : 4321
678 : 876
-12 : -21
432 : 234
1147483647 : 0
*/
    
    
