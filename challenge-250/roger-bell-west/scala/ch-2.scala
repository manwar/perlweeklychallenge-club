import scala.collection.mutable.ListBuffer

object Alphanumericstringvalue {

  def alphanumericstringvalue(a: List[String]): Int = {
    var l = new ListBuffer[Int]
    for (n <- a) {
      val p = try {
        n.toInt
      } catch {
        case e: NumberFormatException =>
          n.length
      }
      l += p
    }
    return l.max
  }
  def main(args: Array[String]) {
    if (alphanumericstringvalue(List("perl", "2", "000", "python", "raku")) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (alphanumericstringvalue(List("001", "1", "000", "0001")) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
