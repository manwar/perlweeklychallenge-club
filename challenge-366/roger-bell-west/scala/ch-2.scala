import scala.collection.mutable.ListBuffer

object Validtimes {
  def validtimes(a: String): Int = {
    var combinator = new ListBuffer[List[Int]]
    for ((c, i) <- a.zipWithIndex) {
      if (c.isDigit) {
        combinator += List(c.asDigit)
      } else {
        val j = i match {
          case 0 => 2
          case 1 | 4 => 9
          case 3 => 5
          case _ => 0
        }
        if (j > 0) {
          var p = new ListBuffer[Int]
          for (x <- 0 to j) {
            p += x
          }
          combinator += p.toList
        }
      }
    }
    if (combinator.size != 4) {
      0
    } else {
      val minutes = combinator(2).size * combinator(3).size
      var ct = 0
      for (ax <- combinator(0)) {
        for (bx <- combinator(1)) {
          if (ax * 10 + bx <= 23) {
            ct += 1
          }
        }
      }
      ct * minutes
    }
  }

  def main(args: Array[String]) {
    if (validtimes("?2:34") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtimes("?4:?0") == 12) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtimes("??:??") == 1440) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtimes("?3:45") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtimes("2?:15") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
