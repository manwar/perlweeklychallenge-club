import scala.collection.mutable.ListBuffer

object Secondlargestdigit {
  def secondlargestdigit(a: String): Int = {
    val k = a.toList.filter(x => x >= '0' && x <= '9').toSet.to[ListBuffer].sortWith(_ > _)
    if (k.size > 1) {
      k(1).asDigit
    } else {
      -1
    }
  }
  def main(args: Array[String]) {
    if (secondlargestdigit("aaaaa77777") == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secondlargestdigit("abcde") == -1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secondlargestdigit("9zero8eight7seven9") == 8) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secondlargestdigit("xyz9876543210") == 8) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secondlargestdigit("4abc4def2ghi8jkl2") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
