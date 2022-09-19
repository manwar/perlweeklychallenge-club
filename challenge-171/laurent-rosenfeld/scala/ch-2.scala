object first_class extends App {
  def compose[A](h1: A => A, h2: A => A) = { x: A => h1(h2(x)) }

  def f(x: Int) = x / 2 + 1
  def g(x: Int) = x * 2

  val h = compose(f, g)
  for (i <- 1 to 6) {
    println(s"${h(i)}  ${f(g(i))}")
  }
}
