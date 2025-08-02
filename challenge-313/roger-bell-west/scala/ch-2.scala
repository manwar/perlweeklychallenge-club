import scala.collection.mutable.ListBuffer

object Reverseletters {
  def reverseletters(a: String): String = {
    var vout = a.toList.to[ListBuffer]
    var letterslots = new ListBuffer[Int]
    var letters = new ListBuffer[Char]
    for ((c, i) <- a.toList.zipWithIndex) {
      if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
        letterslots += i
        letters += c
      } else {
        vout(i) = c
      }
    }
    for (i <- letterslots) {
      vout(i) = letters.last
      letters = letters.dropRight(1)
    }
    vout.mkString("")
  }
  def main(args: Array[String]) {
    if (reverseletters("p-er?l") == "l-re?p") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseletters("wee-k!L-y") == "yLk-e!e-w") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reverseletters("_c-!h_all-en!g_e") == "_e-!g_nel-la!h_c") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
