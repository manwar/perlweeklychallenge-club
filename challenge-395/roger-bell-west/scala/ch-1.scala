import scala.util.matching.Regex

object Complexnumber {
  def parsecomplex(a: String): Tuple2[Int, Int] = {
    val re: Regex = "^\\(?([-0-9]+)\\)?\\+\\(?([-0-9]+)\\)?i$".r
    a match {
      case re(aa, bb) => {
        Tuple2(aa.toInt, bb.toInt)
      }
      case _ => Tuple2(0, 0)
    }
  }
  def complexnumber(aa: String, bb: String): String = {
    val (a, b) = parsecomplex(aa)
    val (c, d) = parsecomplex(bb)
    val ca = a * c - b * d
    val cb = a * d + b * c
    if (cb >= 0) {
      ca.toString + "+" + cb.toString + "i"
    } else {
      ca.toString + "+(" + cb.toString + ")i"
    }
  }
  def main(args: Array[String]) {
    if (complexnumber("1+1i", "1+1i") == "0+2i") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (complexnumber("1+(-1)i", "1+(-1)i") == "0+(-2)i") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (complexnumber("0+3i", "0+4i") == "-12+0i") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (complexnumber("3+4i", "3+(-4)i") == "25+0i") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (complexnumber("50+-20i", "-10+30i") == "100+1700i") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
