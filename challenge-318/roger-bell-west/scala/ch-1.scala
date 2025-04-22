import scala.collection.mutable.ListBuffer

object Groupposition {
  def groupposition(a: String): List[String] = {
    var mx = new ListBuffer[Tuple2[Char, Int]]
    var lc = 'z'
    for ((c, i) <- a.toCharArray.zipWithIndex) {
      if (i == 0) {
        lc = (c.toInt + 1).toChar
      }
      if (lc == c) {
        val mc = mx.size
        mx(mc - 1) = Tuple2(mx(mc - 1)._1, mx(mc - 1)._2 + 1)
      } else {
        mx += Tuple2(c, 1)
        lc = c
      }
    }
    var out = new ListBuffer[String]
    for (ms <- mx) {
      if (ms._2 >= 3) {
        out += ms._1.toString * ms._2
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (groupposition("abccccd") == List("cccc")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupposition("aaabcddddeefff") == List("aaa", "dddd", "fff")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (groupposition("abcdd") == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
