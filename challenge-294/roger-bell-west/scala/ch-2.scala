import scala.collection.mutable.ListBuffer

object Nextpermutation {
  def permute(aa: List[Int]): ListBuffer[List[Int]] = {
    var a = new ListBuffer[Int]
    for (i <- aa) {
      a += i
    }
    var out = new ListBuffer[List[Int]]
    val n = a.size
    var c = new ListBuffer[Int]
    for (i <- 0 to n-1) {
      c += 0
    }
    out += a.toList
    var i = 0
    while (i < n) {
      if (c(i) < i) {
        if (i % 2 == 0) {
          val tmp = a(0)
          a(0) = a(i)
          a(i) = tmp
        } else {
          val tmp = a(c(i))
          a(c(i)) = a(i)
          a(i) = tmp
        }
        out += a.toList
        c(i) += 1
        i = 0
      } else {
        c(i) = 0
        i += 1
      }
    }
    return out
  }
  def listsort(a: List[Int], b: List[Int]): Boolean = {
    var ix = 0
    var loop = true
    var res = false
    while (loop) {
      if (ix >= a.length && ix >= b.length) {
        loop = false
      }
       if (loop && ix < a.length && ix >= b.length) {
        res = true
        loop = false
      }
       if (loop && ix >= a.length && ix < b.length) {
        res = false
        loop = false
       }
      if (loop && a(ix) != b(ix)) {
        res = a(ix) < b(ix)
        loop = false
      }
      ix += 1
    }
    res
  }
  def nextpermutation(a: List[Int]): List[Int] = {
    val b = a.sortWith(_ < _)
    var flag = false
    var out = List(0)
    for (px <- permute(b).sortWith(listsort(_, _))) {
      val py = px
      if (out.length == 1) {
        out = py
      }
      if (flag) {
        out = py
        flag = false
      }
      if (py == a) {
        flag = true
      }
    }
    out
  }
  def main(args: Array[String]) {
    if (nextpermutation(List(1, 2, 3)) == List(1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nextpermutation(List(2, 1, 3)) == List(2, 3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (nextpermutation(List(3, 1, 2)) == List(3, 2, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
