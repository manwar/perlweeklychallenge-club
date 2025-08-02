import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Dictionaryrank {
  def permute(aa: List[Char]): ListBuffer[List[Char]] = {
    var a = new ListBuffer[Char]
    for (i <- aa) {
      a += i
    }
    var out = new ListBuffer[List[Char]]
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
  def dictionaryrank(a: String): Int = {
    val c = a.toList
    var d = mutable.Set.empty[String]
    for (o <- permute(c)) {
      d += o.mkString("")
    }
    var dd = d.to[ListBuffer]
    dd = dd.sortWith(_ < _)
    var r = 0
    for ((s, i) <- dd.zipWithIndex) {
      if (s == a) {
        r = i + 1
      }
    }
    r
  }
  def main(args: Array[String]) {
    if (dictionaryrank("CAT") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dictionaryrank("GOOGLE") == 88) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dictionaryrank("SECRET") == 255) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
