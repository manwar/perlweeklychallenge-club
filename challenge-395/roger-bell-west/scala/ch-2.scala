import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Wordsquares {
  def wordsquares(a: List[String]): List[String] = {
    val l = a(0).size
    val words = a.toSet
    var queue = mutable.Queue.empty[List[String]]
    for (w <- a) {
      queue += (List(w))
    }
    var ret = List[String]()
    while (queue.size > 0) {
      val p = queue.dequeue
      if (p.size == l) {
        queue.clear
        ret = p
      } else {
        for (ca <- words.diff(p.toSet)) {
          var valid = true
          var lp = true
          for ((c, i) <- ca.zipWithIndex) {
            if (lp) {
              if (i >= p.size) {
                lp = false
              }
              if (lp && c != p(i)(p.size)) {
                valid = false
                lp = false
              }
            }
          }
          if (valid) {
            var pw = p.to[ListBuffer]
            pw += ca
            queue += (pw.toList)
          }
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (wordsquares(List("MA", "AM", "MY", "ME")) == List("MA", "AM")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordsquares(List("SUN", "USE", "NET", "SEE", "TEN")) == List("SUN", "USE", "NET")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordsquares(List("BOAT", "TEAL", "AREA", "TSAR", "OGRE")) == List("BOAT", "OGRE", "AREA", "TEAL")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordsquares(List("CARD", "AREA", "REAR", "DART")) == List("CARD", "AREA", "REAR", "DART")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordsquares(List("HEART", "TREND", "EMBER", "RESIN", "ABUSE")) == List("HEART", "EMBER", "ABUSE", "RESIN", "TREND")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
