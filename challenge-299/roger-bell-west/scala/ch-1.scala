import scala.collection.mutable.ListBuffer

object Replacewords {
  def replacewords(ww: List[String], a: String): String = {
    var out = new ListBuffer[String]
    for (w <- a.split(" ")) {
      var r = false
      for (lw <- ww) {
        if (!r && w.startsWith(lw)) {
          out += lw
          r = true
        }
      }
      if (!r) {
        out += w
      }
    }
    out.mkString(" ")
  }
  def main(args: Array[String]) {
    if (replacewords(List("cat", "bat", "rat"), "the cattle was rattle by the battery") == "the cat was rat by the bat") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (replacewords(List("a", "b", "c"), "aab aac and cac bab") == "a a a c b") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (replacewords(List("man", "bike"), "the manager was hit by a biker") == "the man was hit by a bike") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
