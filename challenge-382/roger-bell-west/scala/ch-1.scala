import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Hamiltoniancycle {
  def isqrt(s: Int): Int = {
    if (s <= 1) {
      return s
    }
    var x0 = s / 2
    var x1 = (x0 + s / x0) / 2
    while (x1 < x0) {
      x0 = x1
      x1 = (x0 + s / x0) / 2
    }
    return x0
  }
  def is_adjacentsquares(param: Int, hc: List[Int]): Boolean = {
    var ret = true
    val hcs = hc.sortWith(_ < _)
    var ref = new ListBuffer[Int]
    for (qi <- 1 to param) {
      ref += qi
    }
    if (ref.toList != hcs) {
      ret = false
    }
    if (ret) {
      for (i <- 0 until param - 1) {
        val pn = hc(i) + hc(i + 1)
        val sn = isqrt(pn)
        if (pn != sn * sn) {
          ret = false
        }
      }
    }
    if (ret) {
      val pn = hc(0) + hc(hc.size - 1)
      val sn = isqrt(pn * pn)
      if (pn != sn) {
        ret = false
      }
    }
    ret
  }
  def hamiltoniancycle(a: Int): List[Int] = {
    if (a < 31) {
      List()
    } else {
      var out = new ListBuffer[Int]
      var perfectsquares = mutable.Set.empty[Int]
      for (p <- 1 to a) {
        perfectsquares += (p * p)
      }
      var neighbours = mutable.Map.empty[Int, mutable.Set[Int]]
      for (x <- 1 to a) {
        for (y <- perfectsquares) {
          if (y > x) {
            val z = y - x
            if (z <= a) {
              {
                var s = mutable.Set.empty[Int]
                if (neighbours.contains(x)) {
                  s = neighbours(x)
                }
                s += z
                neighbours += (x -> s)
              }
              {
                var s = mutable.Set.empty[Int]
                if (neighbours.contains(z)) {
                  s = neighbours(z)
                }
                s += x
                neighbours += (z -> s)
              }
            }
          }
        }
      }
      var stack = new ListBuffer[ListBuffer[Int]]
      stack += List(1).to[ListBuffer]
      while (stack.size > 0) {
        val lst = stack.last
        stack = stack.dropRight(1)
        if (lst.size == a) {
          if (perfectsquares.contains(lst(0) + lst(lst.size - 1))) {
            out = lst.to[ListBuffer]
            stack.clear
          }
        } else {
          for (candidate <- neighbours(lst(lst.size - 1))) {
            if (!lst.contains(candidate)) {
              var nlst = lst.toList.to[ListBuffer]
              nlst += candidate
              stack += nlst
            }
          }
        }
      }
      out.toList
    }
  }
  def main(args: Array[String]) {
    if (is_adjacentsquares(32, hamiltoniancycle(32))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (hamiltoniancycle(15) == List.empty) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (is_adjacentsquares(34, hamiltoniancycle(34))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
