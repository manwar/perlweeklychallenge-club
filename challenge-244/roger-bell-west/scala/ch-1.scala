import scala.collection.mutable

object Countsmaller {
  def countsmaller(nums: List[Int]): List[Int] = {
    val b = nums.sortWith(_ < _)
    var sm = mutable.Map.empty[Int, Int]
    var l = 0
    for ((e, i) <- b.zipWithIndex) {
      if (i == 0 || e != l) {
        sm += (e -> i)
        l = e
      }
    }
    return nums.map(n => sm(n)).toList
  }
  def main(args: Array[String]) {
      if (countsmaller(List(8, 1, 2, 2, 3)) == List(4, 0, 1, 1, 3)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (countsmaller(List(6, 5, 4, 8)) == List(2, 1, 0, 3)) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (countsmaller(List(2, 2, 2)) == List(0, 0, 0)) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
