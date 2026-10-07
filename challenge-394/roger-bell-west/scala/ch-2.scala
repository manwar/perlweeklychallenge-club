import scala.collection.mutable.ListBuffer

object Alternatingvowelsconsonants {
  def common_substring(a0: List[String]): List[String] = {
    val a = a0.sortWith(_.length < _.length)
    var results = new ListBuffer[String]
    for (l <- a(0).length - 1 to 1 by -1) {
      for (offset <- 0 to a(0).length - l) {
        var m = true
        val sample = a(0).substring(offset, l + offset)
        for (axi <- 1 until a.size) {
          if (m && a(axi).indexOf(sample) == -1) {
            m = false
          }
        }
        if (m) {
          results += sample;
        }
      }
      // if we wanted longest common substring we'd exit here
      // on non-empty results
    }
    results.toList
  }
  def is_avc(a: String): Boolean = {
    var valid = true
    var laststate = false
    for ((c, i) <- a.toList.zipWithIndex) {
      var thisstate = false
      if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
        thisstate = true
      }
      if (i > 0 && thisstate == laststate) {
        valid = false
      }
      laststate = thisstate
    }
    valid
  }
  def alternatingvowelsconsonants(a: List[String]): List[String] = {
    val c2 = common_substring(a).filter(x => is_avc(x))
    if (c2.size > 0) {
      val l = c2(0).length
      c2.filter(x => x.length == l)
    } else {
      List()
    }
  }
  def main(args: Array[String]) {
    if (alternatingvowelsconsonants(List("relocate", "delocate", "allocate")) == List("locate")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(List("apple", "banana", "cherry")) == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(List("navigate", "cavity", "gravity")) == List("avi")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(List("pedalgia", "pedalboard", "pedantic")) == List("peda")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(List("schoolmaster", "schoolhouse", "schooling")) == List("ho", "ol")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
