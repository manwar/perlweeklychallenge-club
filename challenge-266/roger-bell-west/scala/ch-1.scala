import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Uncommonwords {
  def getlistset(a: String): (List[String], Set[String]) = {
    var la = a.split(" ").toList
    var ca = mutable.Map.empty[String, Int].withDefaultValue(0)
    for (w <- la) {
      ca += (w -> (ca(w) + 1))
    }
    la = la.filter(w => (ca(w) == 1)).toList
    val cb = ca.keys.toSet
    (la, cb)
  }

  def uncommonwords(a: String, b: String): List[String] = {
    val (la, sa) = getlistset(a)
    val (lb, sb) = getlistset(b)
    var out = new ListBuffer[String]
    for ((wl, t) <- List((la, sb), (lb, sa))) {
      for (w <- wl) {
        if (!t.contains(w)) {
          out += w
        }
      }
    }
    out.toList
  }

  def main(args: Array[String]) {
    if (uncommonwords("Mango is sweet", "Mango is sour") == List("sweet", "sour")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uncommonwords("Mango Mango", "Orange") == List("Orange")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uncommonwords("Mango is Mango", "Orange is Orange") == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
    
  }
}
