import scala.collection.mutable.ListBuffer

object Sortcolumn {
  def sortcolumn(a: List[String]): Int = {
    var vv = new ListBuffer[ListBuffer[Char]]
    for ((s, i) <- a.zipWithIndex) {
      for ((c, j) <- s.toList.zipWithIndex) {
        if (i == 0) {
          vv += new ListBuffer[Char]
        }
        vv(j) += c
      }
    }
    var tot = 0
    for (x <- vv) {
      var y = x.sortWith(_ < _)
      if (x != y) {
        tot += 1
      }
    }
    tot
  }
  def main(args: Array[String]) {
    if (sortcolumn(List("swpc", "tyad", "azbe")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortcolumn(List("cba", "daf", "ghi")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sortcolumn(List("a", "b", "c")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
