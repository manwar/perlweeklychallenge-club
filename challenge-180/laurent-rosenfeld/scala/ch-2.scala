object trimList extends App {
  val tests: List[List[List[Int]]] = List(
    List(List(3), List(1, 4, 2, 3, 5)),
    List(List(4), List(9, 0, 6, 2, 3, 8, 5))
  )
  for (test <- tests) {
    val i = test(0)(0)
    val nums = test(1)
    print(s"i: $i, nums: " + nums.mkString(" "))
    println(" => " + nums.filter(_ > i).mkString(" "))
  }
}
