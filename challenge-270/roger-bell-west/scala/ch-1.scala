import scala.collection.mutable

object Specialpositions {
  def validator(a0: List[Int]): Int = {
    val a = a0.sortWith(_ < _)
    val l = a.size
    var p = -1;
    if (a(0) == 0 && a(l - 2) == 0 && a(l - 1) == 1) {
      p = a0.indexOf(1)
    }
    p
  }

  def specialpositions(a: List[List[Int]]): Int = {
    var vr = mutable.Set.empty[Tuple2[Int, Int]]
    var xs = mutable.Set.empty[Int]
    for ((row, y) <- a.zipWithIndex) {
      val x = validator(row)
      if (x > -1) {
        vr += ((y, x))
        xs += x
      }
    }
    for (x <- xs) {
      val c = a.map{r => r(x) }.toList
      if (validator(c) == -1) {
        xs -= x
      }
    }
    return vr.filter(yx => xs.contains(yx._2)).size
  }
  def main(args: Array[String]) {
    if (specialpositions(List(List(1, 0, 0), List(0, 0, 1), List(1, 0, 0))) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (specialpositions(List(List(1, 0, 0), List(0, 1, 0), List(0, 0, 1))) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
