import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Deleteandearn {
  def deleteandearn(a: List[Int]): Int = {
    var ct =  mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (c <- a) {
      ct += (c -> (ct(c) + 1))
    }
    var mx = 0
    var stack = new ListBuffer[Tuple2[mutable.Map[Int, Int], Int]]
    stack += Tuple2(ct, 0)
    while (stack.size > 0) {
      val c = stack.last
      stack = stack.dropRight(1)
      if (c._1.size == 0) {
        mx = List(mx, c._2).max
      } else {
        for (d <- c._1.keys) {
          var cc =  mutable.Map.empty[Int, Int].withDefaultValue(0)
          for (cx <- c._1.keys) {
            cc += (cx -> c._1(cx))
          }
          cc(d) -= 1
          if (cc(d) == 0) {
            cc.remove(d)
          }
          cc.remove(d + 1)
          cc.remove(d - 1)
          stack += Tuple2(cc, c._2 + d)
        }
      }
    }
    mx
  }
  def main(args: Array[String]) {
    if (deleteandearn(List(3, 4, 2)) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (deleteandearn(List(2, 2, 3, 3, 3, 4)) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
