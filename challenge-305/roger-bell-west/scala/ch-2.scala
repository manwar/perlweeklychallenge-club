import scala.collection.mutable

object Aliendictionary {
  def aliendictionary(a: List[String], dc: List[Char]): List[String] = {
    val mxl = a.map(x => x.length).max
    var dh = mutable.Map.empty[Char, Int]
    for ((c, i) <- dc.zipWithIndex) {
      dh += (c -> i)
    }
    var numerics = mutable.Map.empty[String, Long]
    for (w <- a) {
      var n = 0.toLong
      val cc = w.toList
      for (i <- 0 until mxl) {
        n *= 27.toLong
        if (i < w.length) {
          n += dh(cc(i)).toLong
        }
      }
      numerics += (w -> n)
    }
    a.sortWith((i, j) => {
      numerics(i) < numerics(j)
    })
  }
  def main(args: Array[String]) {
    if (aliendictionary(List("perl", "python", "raku"), List('h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z')) == List("raku", "python", "perl")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(' ')
    if (aliendictionary(List("the", "weekly", "challenge"), List('c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z')) == List("challenge", "the", "weekly")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
