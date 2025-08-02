import scala.collection.mutable.ListBuffer

object Distributeelements {
  def distributeelements(a: List[Int]): List[Int] = {
    var x = new ListBuffer[Int]
    x += a(0)
    var y = new ListBuffer[Int]
      y += a(1)
    a.drop(2).foreach(n => {
      if (x.last > y.last) {
        x += n
      } else {
        y += n
      }
    })
    x.appendAll(y)
    x.toList
  }
  def main(args: Array[String]) {
    if (distributeelements(List(2, 1, 3, 4, 5)) == List(2, 3, 4, 5, 1)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (distributeelements(List(3, 2, 4)) == List(3, 4, 2)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (distributeelements(List(5, 4, 3, 8)) == List(5, 3, 4, 8)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
