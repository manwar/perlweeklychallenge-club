import Array._
object jumpGame extends App {
  val tests =
    Array(
      Array(Array(2, 6), Array(1, 4), Array(8, 10)),
      Array(Array(5, 8), Array(1, 2), Array(3, 7)),
      Array(Array(10, 11), Array(1, 5), Array(7, 9))
    )

  for (test <- tests) {
    printArray(test)
    val sorted = test.sortWith(_(0) < _(0))
    printArray(sorted)
    var result = Array.empty[Array[Int]]
    val first = sorted(0)
    var start = first(0)
    var end = first(1)
    for (item <- sorted) {
      if (item(0) > end) {
        result = result :+ Array(start, end)
        start = item(0)
      }
      end = item(1)
    }
    result = result :+ Array(start, end)
    print("Result: ")
    printArray(result)
    println(" ")
  }
  def printArray(input: Array[Array[Int]]): Unit = {
    for (item <- input) {
      print(s"( ${item(0)} ${item(1)} ) ")
    }
    println()
  }
}
