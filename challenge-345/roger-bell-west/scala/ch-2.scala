import scala.collection.mutable.ListBuffer

object Lastvisitor {
  def lastvisitor(a: List[Int]): List[Int] = {
    var seen = new ListBuffer[Int]
    var ans = new ListBuffer[Int]
    var minusones = 0
    for (n <- a) {
      if (n == -1) {
        minusones += 1
        if (minusones <= seen.size) {
          ans += seen(minusones - 1)
        } else {
          ans += -1
        }
      } else {
        n +=: seen
        minusones = 0
      }
    }
    ans.toList
  }
  def main(args: Array[String]) {
    if (lastvisitor(List(5, -1, -1)) == List(5, -1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastvisitor(List(3, 7, -1, -1, -1)) == List(7, 3, -1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastvisitor(List(2, -1, 4, -1, -1)) == List(2, 4, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastvisitor(List(10, 20, -1, 30, -1, -1)) == List(20, 30, 20)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (lastvisitor(List(-1, -1, 5, -1)) == List(-1, -1, 5)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
