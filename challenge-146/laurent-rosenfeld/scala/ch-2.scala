object fraction_tree extends App {

  def findParent(pair: List[Int]): List[Int] = {
    val num = pair(0)
    val denom = pair(1)
    return if (num < denom) List(num, denom - num) else List(num - denom, denom)
  }
  def n2str(pair: List[Int]): String = {
    return s"${pair(0)}" + "/" + s"${pair(1)}"
  }

  val tests: List[List[Int]] = List(List(5, 2), List(2, 5), List(3, 4))
  for (test <- tests) {
    val parent = findParent(test)
    val gd_parent = findParent(parent)
    println(n2str(test) + " - Parent: " + n2str(parent) + " - Grand-parent: " + n2str(gd_parent))
  }
}
