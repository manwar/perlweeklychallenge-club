
object Maxoddbinary {
  def maxoddbinary(a: String): String = {
    var ones = 0
    var zeroes = 0
    for (c <- a) {
      if (c == '0') {
        zeroes += 1
      } else if (c == '1') {
        ones += 1
      }
    }
    if (ones < 1) {
      ""
    } else {
      var out = ""
      for (i <- 1 until ones) {
        out += "1"
      }
      for (i <- 1 to zeroes) {
        out += "0"
      }
      out += "1"
      out
    }
  }

  def main(args: Array[String]) {
    if (maxoddbinary("1011") == "1101") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxoddbinary("100") == "001") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxoddbinary("111000") == "110001") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxoddbinary("0101") == "1001") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (maxoddbinary("1111") == "1111") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
