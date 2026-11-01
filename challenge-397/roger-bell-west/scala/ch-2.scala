import scala.collection.mutable.ListBuffer

object Binaryreflection {
  def reflect(a: Int): Int = {
    var p = new ListBuffer[Int]
    var am = a
    do {
      p += (am % 2)
      am = am >> 1
    } while (am > 0)
      var ar = 0
    var s = p.size
    for (n <- p) {
      s = s - 1
      ar += n << s
    }
    ar
  }

  def binaryreflection(ax: List[Int]): List[Int] = {
    val k = ax.map( x => reflect(x) )
    val i =(0 until ax.size).to[ListBuffer]
    i.sortWith((a, b) => {
      k(a) < k(b) || ax(a) < ax(b)
    }).map(x => ax(x)).toList
  }

  def main(args: Array[String]) {
    if (binaryreflection(List(3, 6, 12)) == List(3, 6, 12)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryreflection(List(1, 2, 4, 8)) == List(1, 2, 4, 8)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryreflection(List(7, 8, 9, 10)) == List(8, 10, 7, 9)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryreflection(List(5, 9, 15, 17)) == List(5, 9, 15, 17)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (binaryreflection(List(11, 13, 14, 19)) == List(14, 13, 11, 19)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
