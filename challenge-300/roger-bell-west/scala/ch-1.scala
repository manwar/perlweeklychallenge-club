import scala.collection.mutable.ListBuffer

object Beautifularrangement {
  def beautifularrangement(a: Int): Int = {
    var precalc = (1 to a + 1).map(x => (1 to a + 1).map(x => false).to[ListBuffer]).to[ListBuffer]
    for (i <- 1 to a) {
      for (j <- Range.inclusive(i, a, i)) {
        precalc(i)(j) = true
        precalc(j)(i) = true
      }
    }
    var ct = 0
    var stack = new ListBuffer[List[Int]]
    stack += (1 to a).toList
    while (stack.size > 0) {
      val trail = stack.last
      stack = stack.dropRight(1)
      if (trail.size == 1) {
        ct += 1
      } else {
        val p = a - trail.size + 2
        for (i <- trail) {
          if (precalc(i)(p)) {
          val tt = trail.filter(x => x != i).toList
            stack += tt
          }
        }
      }
    }
    ct
  }
  def main(args: Array[String]) {
    if (beautifularrangement(2) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (beautifularrangement(1) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (beautifularrangement(10) == 700) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (beautifularrangement(20) == 1939684) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
