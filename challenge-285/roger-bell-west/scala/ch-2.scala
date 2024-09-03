import scala.collection.mutable.ListBuffer

object Makingchange {
// by Tim at https://stackoverflow.com/questions/54330356/scala-create-all-possible-permutations-of-a-sentence-based-synonyms-of-each-wor
def cartesianproduct[T](list: Traversable[Traversable[T]]): Traversable[Traversable[T]] =
  list match {
    case Nil => Nil
    case x :: Nil => x map (Traversable(_))
    case x :: xs =>
      val xsJoin = cartesianproduct(xs)
      for {
        i <- x
        j <- xsJoin
      } yield {
        Traversable(i) ++ j
      }
  }

  def makingchange(a: Int): Int = {
    val coins = List(1, 5, 10, 25, 50)
    val max = coins.map(x => a / x)
    var pat = new ListBuffer[List[Int]]
    for (i <- 0 until coins.length) {
      if (max(i) > 0) {
        pat += (0 to max(i)).toList
      }
    }
    var ct = 0
    for (cc <- cartesianproduct(pat.toList)) {
      val combo = cc.toList
      var t = 0
      for ((c, i) <- combo.zipWithIndex) {
        t += c * coins(i)
      }
      if (t == a) {
        ct += 1
      }
    }
    return ct
  }
  def main(args: Array[String]) {
    if (makingchange(9) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (makingchange(15) == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (makingchange(100) == 292) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
