
object Largestnumber {
  def largestnumber(a: List[Int]): Int = {
    val ax = a.map(x => x.toString).toList
    val ay = ax.sortWith((i, j) => {
      val ij = (i + j).toInt
      val ji = (j + i).toInt
      ij < ji
    }).reverse
    ay.mkString("").toInt
  }
  def main(args: Array[String]) {
    if (largestnumber(List(20, 3)) == 320) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (largestnumber(List(3, 30, 34, 5, 9)) == 9534330) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
