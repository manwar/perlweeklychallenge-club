import scala.collection.mutable.ListBuffer

object Rightinterval {
  def rightinterval(a: List[List[Int]]): List[Int] = {
    val ss = a.map(x => x(0))
    var si = (0 until a.size).to[ListBuffer]
    si = si.sortWith(ss(_) < ss(_))
    var out = new ListBuffer[Int]
    for (l <- a) {
      val ix = si.filter(x => ss(x) >= l(1)).toList
      if (ix.size == 0) {
        out += -1
      } else {
        out += ix(0)
      }
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (rightinterval(List(List(3, 4), List(2, 3), List(1, 2))) == List(-1, 0, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rightinterval(List(List(1, 4), List(2, 3), List(3, 4))) == List(-1, 2, -1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rightinterval(List(List(1, 2))) == List(-1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (rightinterval(List(List(1, 4), List(2, 2), List(3, 4))) == List(-1, 1, -1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
