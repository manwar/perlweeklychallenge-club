import scala.collection.mutable.ListBuffer

object Formatphonenumber {
  def formatphonenumber(a: String): String = {
    val pure = a.toList.filter(it => it >= '0' && it <= '9')
    var left = pure.size
    var out = new ListBuffer[Char]
    var i = 0
    if (left > 4) {
      var x = true
      for (c <- pure) {
        if (x) {
          out += c
          i += 1
          left -= 1
          if (i % 3 == 0) {
            out += '-'
            if (left <= 4) {
              x = false
            }
          }
        }
      }
    }
    if (left == 4) {
      out += pure(i)
      out += pure(i + 1)
      out += '-'
      i += 2
    }
    for (p <- i until pure.size) {
      out += pure(p)
    }
    out.mkString
  }
  def main(args: Array[String]) {
    if (formatphonenumber("1-23-45-6") == "123-456") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatphonenumber("1234") == "12-34") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatphonenumber("12 345-6789") == "123-456-789") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatphonenumber("123 4567") == "123-45-67") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (formatphonenumber("123 456-78") == "123-456-78") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
