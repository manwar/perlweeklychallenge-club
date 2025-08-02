object Circular {
  def circular(a: List[String]): Boolean = {
    var ret = true
    for (p <- a.sliding(2)) {
      if (!p(1).startsWith(p(0).last.toString)) {
        ret = false
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (circular(List("perl", "loves", "scala"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!circular(List("love", "the", "programming"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (circular(List("java", "awk", "kotlin", "node.js"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
