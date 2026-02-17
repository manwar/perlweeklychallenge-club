import scala.collection.mutable.ListBuffer

object Zeckendorfrepresentation {
  def zeckendorfrepresentation (a: Int): List[Int] = {
    var fib = List(0, 1).to[ListBuffer]
    while (fib(fib.size - 1) <= a) {
      fib += (fib(fib.size - 1) + fib(fib.size - 2))
    }
    fib = fib.dropRight(1)
    var res = new ListBuffer[Int]
    var aw = a
    while (aw > 0) {
      val fl = fib.size - 1
      res += fib(fl)
      aw -= fib(fl)
      fib = fib.dropRight(1)
      fib = fib.dropRight(1)
      while (fib(fib.size - 1) > aw) {
        fib = fib.dropRight(1)
      }
    }
    res.toList
  }

  def main(args: Array[String]) {
    if (zeckendorfrepresentation(4) == List(3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(12) == List(8, 3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(20) == List(13, 5, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(96) == List(89, 5, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(100) == List(89, 8, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
