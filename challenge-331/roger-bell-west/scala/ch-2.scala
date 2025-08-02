import scala.collection.mutable.ListBuffer

object Buddystrings {
  def buddystrings(a: String, b: String): Boolean = {
    val ac = a.to[ListBuffer]
    val bc = b.to[ListBuffer]
    var v = false
    for (i <- 0 until a.length - 1) {
      for (j <- i + 1 until a.length) {
        var acx = a.to[ListBuffer]
        acx(i) = ac(j)
        acx(j) = ac(i)
        if (acx == bc) {
          v = true
        }
      }
    }
    v
  }
  def main(args: Array[String]) {
    if (buddystrings("fuck", "fcuk")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!buddystrings("love", "love")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (buddystrings("fodo", "food")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (buddystrings("feed", "feed")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
