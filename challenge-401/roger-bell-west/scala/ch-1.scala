import scala.collection.mutable.ListBuffer

object Fractionaladditionsubstraction {
  def gcd(m0: Int,n0: Int): Int = {
    var m=m0
    var n=n0
    while (n != 0) {
      val tmp=m % n
      m = n
      n = tmp
    }
    m
  }
  def lcm(m: Int, n: Int): Int = {
    m / gcd(m, n) * n
  }
  class Rational(n0: Int, d0: Int) {
    var n: Int = n0
    var d: Int = d0
    def add(other: Rational): Rational = {
      var xd = lcm(d, other.d)
      var xn = n * xd / d + other.n * xd / other.d
      val dv = gcd(xn, xd)
      if (dv > 1) {
        xn /= dv
        xd /= dv
      }
      new Rational(xn, xd)
    }
    def stringify(): String = {
      n.toString + "/" + d.toString
    }
  }
  def fractionaladditionsubstraction(a: String): String = {
    var terms = new ListBuffer[Rational]
    var state = 0
    var n = 0
    var num = 0
    var sign = 0
    val cv = a.toList
    var i = 0
    while (i < cv.size) {
      state match {
        case 0 => {
          cv(i) match {
            case '+' => {
              state = 0
              i += 1
            }
            case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' => {
              sign = 1
              state = 1
              n = cv(i).asDigit
              i += 1
            }
            case '-' => {
              sign = -1
              state = 1
              n = 0
              i += 1
            }
          }
        }
        case 1 => {
          cv(i) match {
            case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' => {
              n = n * 10 + cv(i).asDigit
              i += 1
            }
            case '/' => {
              num = n * sign
              n = 0
              state = 2
              i += 1
            }
          }
        }
        case 2 => {
          cv(i) match {
            case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' => {
              n = n * 10 + cv(i).asDigit
              i += 1
            }
            case _ => {
              terms += new Rational(num, n)
              state = 0
            }
          }
        }
      }
    }
    if (state == 2) {
      terms += new Rational(num, n)
    }
    var out = terms(0)
    for (nti <- 1 until terms.size) {
      out = out.add(terms(nti))
    }
    return out.stringify
  }
  def main(args: Array[String]) {
    if (fractionaladditionsubstraction("1/2+3/2") == "2/1") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("-5/2-3/2") == "-4/1") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("5/3-5/3") == "0/1") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("10/10-1/10+2/5") == "13/10") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("1/6+1/6+1/6") == "1/2") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
