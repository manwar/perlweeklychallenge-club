object Checkcolor {

  def cs2xy(a: String): List[Int] = {
    val c = a.toList
    val x = c(0).toInt - 'a'.toInt
    val y = c(1).toInt - '1'.toInt
    return List(x, y)
  }

  def checkcolor(a: String): Boolean = {
    val xy = cs2xy(a)
    return (xy(0) + xy(1)) % 2 == 1
  }

  def main(args: Array[String]) {
    if (checkcolor("d3")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!checkcolor("g5")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (checkcolor("e6")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
