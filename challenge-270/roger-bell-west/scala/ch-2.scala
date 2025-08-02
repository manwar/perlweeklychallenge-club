import scala.collection.mutable.ListBuffer
import scala.collection.mutable.Queue

object Equalizearray {
  class Op(xa: List[Int], xcost: Int) {
    var a = xa
    var cost = xcost
  }

  def equalizearray(a0: List[Int], x: Int, y: Int): Int = {
    val a = a0.sortWith(_ < _)
    val limit = a.last
    var queue = Queue(new Op(a, 0))
    var mc = -1
    while (queue.size > 0) {
      val op = queue.dequeue
      if (mc == -1 || mc > op.cost) {
        if (op.a(0) == op.a.last) {
          mc = op.cost
        } else {
          var p = op.a.to[ListBuffer]
          p(0) += 1
          if (p(0) <= limit) {
            p = p.sortWith(_ < _)
            queue += new Op(p.toList, op.cost + x)
            var q = op.a.to[ListBuffer]
            q(0) += 1
            q(1) += 1
            if (q(1) <= limit) {
              q = q.sortWith(_ < _)
              queue += new Op(q.toList, op.cost + y)
            }
          }
        }
      }
    }
    return mc
  }
  def main(args: Array[String]) {
    if (equalizearray(List(4, 1), 3, 2) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (equalizearray(List(2, 3, 3, 3, 5), 2, 1) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
