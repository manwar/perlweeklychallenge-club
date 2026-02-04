
object Digitalroot {
  def digitalroot(a: Int): List[Int] = {
    var count = 0
    var value = a
    while (value > 9) {
      var p = 0
      while (value > 0) {
        p += value % 10
        value /= 10
      }
      value = p
      count += 1
    }
    List(count, value)
  }
  def main(args: Array[String]) {
    if (digitalroot(38) == List(2, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (digitalroot(7) == List(0, 7)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (digitalroot(999) == List(2, 9)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (digitalroot(1999999999) == List(3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (digitalroot(101010) == List(1, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
