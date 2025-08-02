import scala.collection.mutable.ListBuffer

object Findthird {
  def findthird(s: String, a: String, b: String): List[String] = {
    var ss = new ListBuffer[String]
    var sa = ""
    for (c <- s.toList) {
      if (c.isLetter) {
        sa += c
      } else {
        if (sa.length > 0) {
          ss += sa
          sa = ""
        }
      }
    }
    if (sa.length > 0) {
      ss += sa
    }
    var out = new ListBuffer[String]
    for (p <- ss.sliding(3)) {
      if (p(0) == a && p(1) == b) {
        out += p(2)
      }
    }
    out.toList
  }
  def main(args: Array[String]) {
    if (findthird("Perl is a my favourite language but Python is my favourite too.", "my", "favourite") == List("language", "too")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findthird("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful") == List("doll", "princess")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findthird("we will we will rock you rock you.", "we", "will") == List("we", "rock")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
