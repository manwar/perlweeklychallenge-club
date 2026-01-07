
object Mountainarray {
  def mountainarray(a: List[Int]): Boolean = {
    var state = 0
    var valid = true
    for (b <- a.sliding(2)) {
      if (b(1) > b(0)) {
        if (state == 0 || state == 1) {
          state = 1
        } else {
          valid = false
        }
      } else if (b(1) < b(0)) {
        if (state == 1 || state == 2) {
          state = 2
        } else {
          valid = false
        }
      } else {
        valid = false
      }
    }
    valid && state == 2
  }

  def main(args: Array[String]) {
    if (!mountainarray(List(1, 2, 3, 4, 5))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (mountainarray(List(0, 2, 4, 6, 4, 2, 0))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!mountainarray(List(5, 4, 3, 2, 1))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!mountainarray(List(1, 3, 5, 5, 4, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (mountainarray(List(1, 3, 2))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
