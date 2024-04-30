object Linecounts {
  def linecounts (a: String, w: List[Int]): List[Int] = {
    var linecount = 1
    var linewidth = 0
    val asize = 'a'.toInt
    for (c <- a.toList) {
      val wd = w(c.toInt - asize)
      if (linewidth + wd > 100) {
        linecount += 1
        linewidth = wd
      } else {
        linewidth += wd
      }
    }
    List(linecount, linewidth)
  }
  def main(args: Array[String]) {
      if (linecounts("abcdefghijklmnopqrstuvwxyz", List(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)) == List(3, 60)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (linecounts("bbbcccdddaaa", List(4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)) == List(2, 4)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
