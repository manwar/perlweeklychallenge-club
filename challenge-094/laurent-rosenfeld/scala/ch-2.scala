import scala.collection.mutable.Queue

object tree2List extends App {
  case class Tree[T](value: T, children: List[Tree[T]])
  val tests = List(
    Tree(1, List(Tree(2, List(Tree(3, Nil), Tree(4, Nil))))),
    Tree(
      1,
      List(
        Tree(2, List(Tree(4, Nil))),
        Tree(3, List(Tree(5, Nil), Tree(6, Nil)))
      )
    ),
    Tree(
      5,
      List(
        Tree(4,
          List(Tree(3, List(Tree(7, Nil), Tree(2, Nil))))),
        Tree(8,
          List(Tree(2, Nil), Tree(9, List(Tree(1, Nil)))))
      )
    )
  )

  def dfs[T, S](tree: Tree[T], f: T => S): Queue[S] = {
    def loop(g: Tree[T], output: Queue[S]): Queue[S] = g match {
      case Tree(v, c) =>
        c.foldLeft(output.enqueue(f(v))) { case (acc, n) => loop(n, acc) }
    }
    loop(tree, Queue.empty[S])
  }

  for (tree <- tests) {
    val traversal = dfs(tree, identity[Int])
    println(traversal.mkString(", "))
  }
}
