
object Chessboardsquares {
  def cs2xy(a: String): Tuple2[Int, Int] = {
    val c = a.toList
    val x = c(0).toInt - 'a'.toInt
    val y = c(1).toInt - '1'.toInt
    return Tuple2(x, y)
  }
  def checkcolor(a: String): Boolean = {
    val xy = cs2xy(a)
    return (xy._1 + xy._2) % 2 == 1
  }
  def chessboardsquares(a: String, b: String): Boolean = {
    checkcolor(a) == checkcolor(b)
  }
  def main(args: Array[String]) {
    if (chessboardsquares("a7", "f4")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!chessboardsquares("c1", "e8")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!chessboardsquares("b5", "h2")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (chessboardsquares("f3", "h1")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!chessboardsquares("a1", "g8")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
