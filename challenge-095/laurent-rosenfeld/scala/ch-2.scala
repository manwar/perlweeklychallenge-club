object stack extends App {
  var stack = Array(1, 2, 3, 4, 5)
  print_stack("Original stack")
  push(Array(6, 7, 8))
  print_stack("Pushed stack")
  val popped = pop
  println(s"Popped: $popped")
  print_stack("Popped stack")
  val topped = top
  println(s"Top: $topped")
  val minimum = min
  println(s"Min: $minimum")
  def print_stack(caption: String) : Unit = {
    print(s"$caption: "); println( stack.mkString(" "))
  }
  def push(newItems: Array[Int]): Unit = {
    stack ++= newItems
  }
  def pop: Int = {
    val lastItem = stack.last
    stack = stack.dropRight(1)
    return lastItem
  }
  def top: Int = {
    return stack.last
  }
  def min: Int = {
    var min = stack(0);
    for (i <- 1 to (stack.length - 1)) {
      if (stack(i) < min) min = stack(i)
    }
    return min
  }
}
