
object Ascendingnumbers {
  // https://alvinalexander.com/scala/using-scala-option-some-none-idiom-function-java-null/
  def toInt(in: String): Option[Int] = {
    try {
      Some(Integer.parseInt(in.trim))
    } catch {
      case e: NumberFormatException => None
    }
  }
  def ascendingnumbers(a: String): Boolean = {
    var prev: Option[Int] = None
    var ret = true
    for (c <- a.split(" ")) {
      toInt(c) match {
        case Some(n) => {
          prev match {
            case Some(p) => {
              if (p >= n) {
                ret = false
              }
            }
            case _ => { }
          }
          prev = Some(n)
        }
        case _ => { }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (ascendingnumbers("The cat has 3 kittens 7 toys 10 beds")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!ascendingnumbers("Bob has 10 cars 10 bikes")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (ascendingnumbers("Zero is 0 one is 1 two is 2")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
