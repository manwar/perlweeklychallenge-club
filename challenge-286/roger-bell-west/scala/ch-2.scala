import scala.collection.mutable.ListBuffer

object Ordergame {
  def ordergame(a: List[Int]): Int = {
    var p = a.to[ListBuffer]
    while (p.size > 1) {
      var q = new ListBuffer[Int]
      var mm = true
      for (j <- p.sliding(2)) {
        if (mm) {
          q += List(j(0), j(1)).min
        } else {
          q += List(j(0), j(1)).max
        }
        mm = !mm
      }
      p = q
    }
    p(0)
  }
  def main(args: Array[String]) {
    if (ordergame(List(2, 1, 4, 5, 6, 3, 0, 2)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (ordergame(List(0, 5, 3, 2)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (ordergame(List(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
