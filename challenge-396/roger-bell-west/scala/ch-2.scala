
object Trionicarray {
  def trionicarray(a: List[Int]): Boolean = {
    var state = 0
    var prev = a(0)
    var ret = true
    for (n <- a.drop(1)) {
      if (ret) {
        var dir = 0
        if (n > prev) {
          dir = 1
        } else if (n < prev) {
          dir = -1
        }
        if (dir == 0) {
          ret = false
        } else {
          state match {
            case 0 => {
              if (dir == 1) {
                state = 1
              } else {
                ret = false
              }
            }
            case 1 => {
              if (dir == -1) {
                state = 2
              }
            }
            case 2 => {
              if (dir == 1) {
                state = 3
              }
            }
            case 3 => {
              if (dir == -1) {
                ret = false
              }
            }
            case _ => {
              ret = false
            }
          }
          prev = n
        }
      }
    }
    if (ret) {
      state == 3
    } else {
      false
    }
  }
  def main(args: Array[String]) {
    if (trionicarray(List(1, 3, 5, 4, 2, 6, 8))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!trionicarray(List(1, 4, 4, 2, 1, 3, 5))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (trionicarray(List(2, 10, 3, 1, 9))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!trionicarray(List(1, 2, 3, 4, 3, 2, 1))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!trionicarray(List(1, 3, 2, 4, 1, 5, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
