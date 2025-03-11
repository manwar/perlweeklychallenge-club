
object Minimumtime {

  def transfer(a: Char, b: Char): Int = {
    val ac = a.toInt
    val bc = b.toInt
    List((ac - bc + 26) % 26, (bc - ac + 26) % 26).min
  }

  def minimumtime(a: String): Int = {
    var tot = a.length
    var prev = 'a'
    for (c <- a.toList) {
      tot += transfer(prev, c)
      prev = c
    }
    tot
  }

  def main(args: Array[String]) {
    if (minimumtime("abc") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minimumtime("bza") == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (minimumtime("zjpc") == 34) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
