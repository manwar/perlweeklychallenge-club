import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Longestrepeatingcharacter {
  def lsub(wm: List[Char], t: Char): Int = {
    var start = 0
    var state = 0
    var ll = new ListBuffer[Int]
    for (n <- 0 until wm.size) {
      if (state == 0) {
        if (wm(n) == t) {
          start = n
          state = 1
        }
      } else {
        if (wm(n) != t) {
          ll += (n - start)
          state = 0
        }
      }
    }
    if (state == 1) {
          ll += (wm.size - start)
    }
    ll.max
  }
  def longestrepeatingcharacter(st: String, k: Int): Int = {
    val origin = st.toList
    val targets = origin.toSet
    var longestsub = 0
    for (t <- targets) {
      var queue = mutable.Queue.empty[Tuple2[List[Char], Int]]
      queue += Tuple2(origin, 0)
      while (queue.size > 0) {
        val (wm, ct) = queue.dequeue
        longestsub = List(longestsub, lsub(wm, t)).max
        if (ct < k) {
          val ctp = ct + 1
          for (n <- 0 until wm.size) {
            if (wm(n) != t) {
              var wmp = wm.to[ListBuffer]
              wmp(n) = t
              queue += Tuple2(wmp.toList, ctp)
            }
          }
        }
      }
    }
    longestsub
  }
  def main(args: Array[String]) {
    if (longestrepeatingcharacter("AAAAA", 2) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestrepeatingcharacter("ABCDE", 4) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestrepeatingcharacter("AAABBBBAA", 1) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestrepeatingcharacter("ABACADA", 2) == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestrepeatingcharacter("BAAABAAAA", 1) == 8) {
      print("Pass")
    } else {
      print("Fail")
     }
    println("")

  }
}
