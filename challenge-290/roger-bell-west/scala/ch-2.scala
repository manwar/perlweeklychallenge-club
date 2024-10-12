import scala.collection.mutable.ListBuffer

object Luhnalgorithm {
  def luhnalgorithm(a: String): Boolean = {
    val d = a
      .toList
      .filter(x => x >= '0' && x <= '9')
      .map(x => x.asDigit)
      .reverse
    val payload = d.head
    var digits = d.tail.to[ListBuffer]
    for (i <- Range(0, digits.length, 2)) {
      digits(i) *= 2
      if (digits(i) > 9) {
        digits(i) -= 9
      }
    }
    10 - (digits.sum % 10) == payload
  }
  def main(args: Array[String]) {
    if (luhnalgorithm("17893729974")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (luhnalgorithm("4137 8947 1175 5904")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!luhnalgorithm("4137 8974 1175 5904")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
