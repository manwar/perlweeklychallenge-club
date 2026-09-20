import scala.collection.mutable.ListBuffer

object Arrangebox {
  def arrangebox(a0: List[List[Int]]): Int = {
    var a = a0.sortWith((i, j) => {
      i(0) < j(0) || i(1) < j(1)
    })
    var stack = new ListBuffer[Tuple2[Int, Int]]
    var mx = 1
    for (i <- 0 until a.size) {
      stack += Tuple2(i, 1)
    }
    while (stack.size > 0) {
      val (ix, pm) = stack.last
      stack = stack.dropRight(1)
      if (pm > mx) {
        mx = pm
      }
      for (j <- ix + 1 until a.size) {
        if (a(ix)(0) < a(j)(0) && a(ix)(1) < a(j)(1)) {
          stack += Tuple2(j, pm + 1)
        }
      }
    }
    mx
  }
  def main(args: Array[String]) {
    if (arrangebox(List(List(1, 3), List(3, 5), List(6, 8), List(2, 4))) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arrangebox(List(List(4, 5), List(4, 6), List(6, 7), List(2, 3), List(4, 3))) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arrangebox(List(List(5, 5), List(5, 5), List(5, 5))) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arrangebox(List(List(2, 100), List(3, 200), List(4, 300), List(5, 50), List(5, 400))) == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (arrangebox(List(List(10, 20), List(15, 10), List(20, 30), List(12, 18), List(16, 25))) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
