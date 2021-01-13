
object gcdSum extends App {

  def gcd(a: Int, b: Int): Int =
    if (b == 0) a else gcd(b, a % b)

  def gcdSum(r: Int): Int = (1 to r).combinations(2).map( x => gcd(x.head,x.last) ).sum

  println(gcdSum(args.head.toInt))
}
