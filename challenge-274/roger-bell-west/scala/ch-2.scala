import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Busroute {
  def busroute(a: List[List[Int]]): List[Int] = {
    var route = new ListBuffer[mutable.Map[Int, Int]];
    for (rt <- a) {
      var ri = mutable.Map.empty[Int, Int];
      val interval = rt(0);
      val offset = rt(1);
      val duration = rt(2);
      var start = offset;
      val end = 61 + offset;
      while (start < end) {
        ri += (start -> (start + duration));
        start += interval;
      }
      route += ri;
    }
    var out = new ListBuffer[Int];
    for (t <- 0 until 60) {
      var best = mutable.Set.empty[Int];
      var at = -1;
      var nxt = mutable.Set.empty[Int];
      var ndt = -1;
      for ((r, i) <- route.zipWithIndex) {
        val nb = r.keys.filter(n => n >= t).min;
        val nt = r(nb);
        if (at == -1 || nt < at) {
          best.clear;
          at = nt;
        }
        if (nt <= at) {
          best += i;
        }
        if (ndt == -1 || nb < ndt) {
          nxt.clear;
          ndt = nb;
        }
        if (nb <= ndt) {
          nxt += i;
        }
      }
      if ((best & nxt).size == 0) {
        out += t;
      }
    }
    return out.toList;
  }
  def main(args: Array[String]) {
    if (busroute(List(List(12, 11, 41), List(15, 5, 35))) == List(36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (busroute(List(List(12, 3, 41), List(15, 9, 35), List(30, 5, 25))) == List(0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
