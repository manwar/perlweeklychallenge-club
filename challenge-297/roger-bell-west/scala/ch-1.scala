
object Contiguousarray {
  def contiguousarray(a: List[Int]): Int = {
    var ret = 0
    val ml = (1 + a.size) / 2 * 2;
    for (l <- Range.inclusive(ml, 2, -2)) {
      if (ret == 0) {
        for (start <- 0 to a.size - l) {
          if (ret == 0) {
            val end = start + l
            if (a.slice(start, end).sum * 2 == l) {
              ret = l
            }
          }
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (contiguousarray(List(1, 0)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (contiguousarray(List(0, 1, 0)) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (contiguousarray(List(0, 0, 0, 0, 0)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (contiguousarray(List(0, 1, 0, 0, 1, 0)) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
