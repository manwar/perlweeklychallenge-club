import scala.collection.mutable

object Shufflepairs {
  def counterify(a: List[Char]): Map[Char, Int] = {
    var cc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }

  def countdigits(a: Int): Map[Char, Int] = {
    counterify(a.toString.toList)
  }

  def shufflepairs(low: Int, high: Int, pairs: Int): Int = {
    var total = 0
    for (candidate <- low to high) {
      val candidatec = countdigits(candidate)
      var cnt = 0
      for (mul <- 2 to 9) {
        if (cnt < pairs) {
          val test = candidate * mul
          val testc = countdigits(test)
          if (testc == candidatec) {
            cnt += 1
          }
        }
      }
      if (cnt >= pairs) {
        total += 1
      }
    }
    total
  }

  def main(args: Array[String]) {
    if (shufflepairs(1, 1000, 1) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shufflepairs(1500, 2500, 1) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shufflepairs(1000000, 1500000, 5) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shufflepairs(13427000, 14100000, 2) == 11) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (shufflepairs(1000, 5000, 1) == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
