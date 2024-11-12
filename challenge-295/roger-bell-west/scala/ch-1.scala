import scala.collection.mutable

object Wordbreak {
  def wordbreak(a: String, words: List[String]): Boolean = {
    var queue = mutable.Queue.empty[String]
    queue += a
    var ret = false
    var lp = true
    while (lp && queue.size > 0) {
      val remnant = queue.dequeue
      if (remnant.length == 0) {
        ret = true
        lp = false
      } else {
        for (candidate <- words) {
          if (remnant.startsWith(candidate)) {
            queue += remnant.drop(candidate.length)
          }
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (wordbreak("weeklychallenge", List("challenge", "weekly"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordbreak("perlrakuperl", List("raku", "perl"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!wordbreak("sonsanddaughters", List("sons", "sand", "daughters"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
