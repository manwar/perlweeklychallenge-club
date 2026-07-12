
object Smallergreaterelement {
  def smallergreaterelement(a: List[Int]): Int = {
    val mn = a.min
    val mx = a.max
    return a.filter(x => x != mn && x != mx).size
  }
  def main(args: Array[String]) {
    if (smallergreaterelement(List(2, 4)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallergreaterelement(List(1, 1, 1, 1)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallergreaterelement(List(1, 1, 4, 8, 12, 12)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallergreaterelement(List(3, 6, 6, 9)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (smallergreaterelement(List(0, -5, 10, -2, 4)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
