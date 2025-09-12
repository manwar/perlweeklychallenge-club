
object Highestrow {
def highestrow(a: List[List[Int]]): Int = {
    a.map( x => x.sum ).max
}

  def main(args: Array[String]) {
    if (highestrow(List(List(4, 4, 4, 4), List(10, 0, 0, 0), List(2, 2, 2, 9))) == 16) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (highestrow(List(List(1, 5), List(7, 3), List(3, 5))) == 10) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (highestrow(List(List(1, 2, 3), List(3, 2, 1))) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (highestrow(List(List(2, 8, 7), List(7, 1, 3), List(1, 9, 5))) == 17) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (highestrow(List(List(10, 20, 30), List(5, 5, 5), List(0, 100, 0), List(25, 25, 25))) == 100) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
