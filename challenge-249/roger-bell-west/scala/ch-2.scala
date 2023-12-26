import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Distringmatch {
  def distringmatch(a: String): List[Int] = {
    var v = 1 << (a.length - 1);
    var wv = v << 1;
    var out = new ListBuffer[Int];
    out += wv;
    for (c <- a) {
      if (c == 'I') {
        wv += v;
      } else {
        wv -= v;
      }
      v >>= 1;
      out += wv;
    }
    var c = mutable.Map.empty[Int, Int]
    for ((v, i) <- out.sortWith(_ < _).zipWithIndex) {
      c += (v -> i)
    }
    return out.map(x => c(x)).toList;
  }
  def main(args: Array[String]) {
    if (distringmatch("IDID") == List(0, 4, 1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (distringmatch("III") == List(0, 1, 2, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (distringmatch("DDI") == List(3, 2, 0, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
