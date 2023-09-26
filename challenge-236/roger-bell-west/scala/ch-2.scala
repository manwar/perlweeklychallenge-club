import scala.collection.mutable

object Arrayloops {
  def arrayloops(a: List[Int]): Int = {
    var loop_id = 0
    var loops = mutable.Map.empty[Int, Int]
    for (origin <- 0 until a.length) {
      if (!loops.contains(origin)) {
        var li = 0
        var thisloop = mutable.Set.empty[Int]
        var x = origin
        var cont = true
        while (cont) {
          if (x < 0 || x >= a.length) {
            cont = false
          } else {
            thisloop += x
            x = a(x)
            if (loops.contains(x)) {
              li = loops(x)
              cont = false
            } else if (thisloop.contains(x)) {
              loop_id += 1
              li = loop_id
              cont = false
            }
          }
        }
        for (i <- thisloop) {
          loops += (i -> li)
        }
      }
    }
    return loop_id
  }

  def main(args: Array[String]) {
      if (arrayloops(List(4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10)) == 3) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (arrayloops(List(0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19)) == 6) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (arrayloops(List(9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17)) == 1) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
