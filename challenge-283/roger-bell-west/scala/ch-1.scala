import scala.collection.mutable

object Uniquenumber {
  def uniquenumber(a: List[Int]): Int = {
   var c = mutable.Map.empty[Int, Int].withDefaultValue(0)
    for (p <- a) {
      c += (p -> (c(p) + 1))
    }
    var ret = -1;
    for (p <- c.keys) {
      if (ret == -1 && c(p) == 1) {
        ret = p
      }
    }
    return ret
  }
  def main(args: Array[String]) {
    if (uniquenumber(List(3, 3, 1)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquenumber(List(3, 2, 4, 2, 4)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquenumber(List(1)) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (uniquenumber(List(4, 3, 1, 1, 1, 4)) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
