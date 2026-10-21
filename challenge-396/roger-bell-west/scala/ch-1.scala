
object Finishingorder {
  def finishingorder(order: List[Int], friends: List[Int]): List[Int] = {
    order.filter(x => friends.contains(x))
  }
  def main(args: Array[String]) {
    if (finishingorder(List(3, 1, 4, 2, 5), List(1, 4, 2)) == List(1, 4, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finishingorder(List(5, 4, 3, 2, 1), List(1, 3, 5)) == List(5, 3, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finishingorder(List(2, 4, 1, 3), List(1, 2, 3, 4)) == List(2, 4, 1, 3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finishingorder(List(4, 1, 3, 2), List(3)) == List(3)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finishingorder(List(1, 3, 2, 6, 5, 4), List(1, 2, 3)) == List(1, 3, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
