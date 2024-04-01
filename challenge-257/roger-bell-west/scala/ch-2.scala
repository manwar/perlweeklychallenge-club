import scala.collection.mutable.ListBuffer

object Reducedrowechelon {
  def reducedrowechelon(a: List[List[Int]]): Boolean = {
    var leadingone = new ListBuffer[Int]()
    var valid = true
    for (row <- a) {
      var lp = -1
      for ((cell, cn) <- row.zipWithIndex) {
        if (lp == -1) {
          if (cell == 1) {
            lp = cn
          } else if (cell != 0) {
            valid = false
          }
        }
      }
      leadingone += lp
    }
    var c = new ListBuffer[Int]
    if (valid) {
      while (leadingone(leadingone.size-1) == -1) {
        leadingone.remove(leadingone.size-1)
      }
      c = leadingone.to[ListBuffer]
      c = c.sortWith(_ < _)
      if (c(0) == -1) {
        valid = false
      }
      if (c !=  leadingone) {
        valid = false
      }
    }
    if (valid) {
      for (i <- c) {
        var col = a.map(n => n(i)).to[ListBuffer]
        col = col.sortWith(_ < _)
        if (col(col.size-1) != 1 ||
          col(col.size-2) != 0||
          col(0) != 0) {
          valid = false
        }
      }
    }
    valid
  }
  def main(args: Array[String]) {
    if (!reducedrowechelon(List(List(1, 1, 0), List(0, 1, 0), List(0, 0, 0)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reducedrowechelon(List(List(0, 1, -2, 0, 1), List(0, 0, 0, 1, 3), List(0, 0, 0, 0, 0), List(0, 0, 0, 0, 0)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reducedrowechelon(List(List(1, 0, 0, 4), List(0, 1, 0, 7), List(0, 0, 1, -1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(List(List(0, 1, -2, 0, 1), List(0, 0, 0, 0, 0), List(0, 0, 0, 1, 3), List(0, 0, 0, 0, 0)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(List(List(0, 1, 0), List(0, 1, 0), List(0, 0, 0)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(List(List(4, 0, 0, 0), List(0, 1, 0, 7), List(0, 0, 1, -1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(List(List(1, 0, 0, 4), List(1, 0, 0, 7), List(0, 0, 1, -1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(List(List(1, -2, 0, 4), List(0, 1, 0, 7), List(0, 0, 1, -1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
