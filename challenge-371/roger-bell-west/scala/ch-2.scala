import scala.collection.mutable.ListBuffer

object Subsetequilibrium {
  def combinations(arr: List[Int], k: Int): List[List[Int]] = {
    var c = new ListBuffer[Int]()
    for (i <- 0 until k) {
      c += i
    }
    c += arr.length
    c += 0
    var out = new ListBuffer[List[Int]]()
    var cont = true
    while (cont) {
      var inner = new ListBuffer[Int]()
      for (i <- List.range(k-1, -1, -1)) {
        inner += arr(c(i))
      }
      out += inner.toList
      var j = 0
      while (c(j) + 1 == c(j + 1)) {
        c(j) = j
        j += 1
      }
      if (j >= k) {
        cont = false
      } else {
        c(j) += 1
      }
    }
    return out.toList
  }

  def subsetequilibrium(a: List[Int]): List[List[Int]] = {
    var out = new ListBuffer[List[Int]]
    val b = a.zipWithIndex.map { case (x, i) => x - i - 1 }.toList
    val ix = (0 until b.size).toList
    for (n <- 1 until b.size) {
      for (iyx <- combinations(ix, n)) {
        val iy = iyx.sortWith(_ < _)
        val bp = iy.map(i => b(i)).sum
        if (bp == 0) {
          val ap = iy.map(i => a(i)).toList
          out += ap
        }
      }
    }
    out.toList.sortWith((i, j) => {
      val kx = List(i.size, j.size).min
      var k = 0
      var cmp = i(0) < j(0)
      while (k < kx) {
        if (i(k) == j(k)) {
          k += 1
        } else {
          cmp = i(k) < j(k)
          k = kx
        }
      }
      cmp
    })
  }

  def main(args: Array[String]) {
    if (subsetequilibrium(List(2, 1, 4, 3)) == List(List(1, 4), List(2, 1), List(2, 3), List(4, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (subsetequilibrium(List(3, 0, 3, 0)) == List(List(3), List(3, 0), List(3, 0, 3))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (subsetequilibrium(List(5, 1, 1, 1)) == List(List(5, 1, 1))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (subsetequilibrium(List(3, -1, 4, 2)) == List(List(3, -1, 4), List(3, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (subsetequilibrium(List(10, 20, 30, 40)) == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
