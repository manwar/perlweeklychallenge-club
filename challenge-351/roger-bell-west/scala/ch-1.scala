
object Specialaverage {
  def specialaverage(a0: List[Int]): Int = {
    val a = a0.sortWith(_ < _)
    val min = a(0)
    val max = a(a.size-1)
    val b = a.filter(x => x != min && x != max)
    if (b.size == 0) {
      0
    } else {
      b.sum / b.size
    }
  }

  def main(args: Array[String]) {
    if (specialaverage(List(8000, 5000, 6000, 2000, 3000, 7000)) == 5250) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (specialaverage(List(100000, 80000, 110000, 90000)) == 95000) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (specialaverage(List(2500, 2500, 2500, 2500)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (specialaverage(List(2000)) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (specialaverage(List(1000, 2000, 3000, 4000, 5000, 6000)) == 3500) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
