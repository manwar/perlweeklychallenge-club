import scala.collection.mutable

object Singlecommonword {
  def counterify(a: List[String]): Map[String, Int] = {
    var cc = mutable.Map.empty[String, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }
  def singlecommonword(a: List[String], b: List[String]): Int = {
    val ac = counterify(a)
    val bc = counterify(b)
    var total = 0
    for ((w, ca) <- ac) {
      if (ca == 1 &&
        bc.contains(w) &&
        bc(w) == 1) {
        total += 1
      }
    }
    total
  }
  def main(args: Array[String]) {
    if (singlecommonword(List("apple", "banana", "cherry"), List("banana", "cherry", "date")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (singlecommonword(List("a", "ab", "abc"), List("a", "a", "ab", "abc")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (singlecommonword(List("orange", "lemon"), List("grape", "melon")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (singlecommonword(List("test", "test", "demo"), List("test", "demo", "demo")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (singlecommonword(List("Hello", "world"), List("hello", "world")) == 1) {
      print("Pass")
    } else {
      print("Fail")
     }
    println("")

  }
}
