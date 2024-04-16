import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Completingword {
  def str2hash(a: String): mutable.Map[Char, Int] = {
    var m = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (c <- a.toList) {
      if (c.isLetter) {
        val lc = c.toLower
        m += (lc -> (m(lc) + 1))
      }
    }
    m
  }
  def completingword(a: String, cw: List[String]): String = {
    val ah = str2hash(a)
    var out = new ListBuffer[String]
    for (t <- cw) {
      var valid = true
      val th = str2hash(t)
      for ((k, v) <- ah) {
        if (valid) {
          if (!th.contains(k)) {
            valid = false
          } else {
            if (th(k) < v) {
              valid = false
            }
          }
        }
      }
      if (valid) {
        out += t
      }
    }
    if (out.size == 0) {
      return ""
    }
    out.sortWith(_.length < _.length)(0)
  }
  def main(args: Array[String]) {
    if (completingword("aBc 11c", List("accbbb", "abc", "abbc")) == "accbbb") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (completingword("La1 abc", List("abcl", "baacl", "abaalc")) == "baacl") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (completingword("JB 007", List("jj", "bb", "bjb")) == "bjb") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
