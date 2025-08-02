//https://theweeklychallenge.org/blog/perl-weekly-challenge-293/
//scala3
//scala ch-1.scala

def similar_dominos( pieces: Seq[ (Int,Int) ] ) =
  pieces
  .map { p => Seq(p._1,p._2) }
  .map { _.sorted }
  .map { _.mkString(" ") }
  .groupBy { identity }
  .values
  .map { _.size }
  .filter { _ > 1 }
  .sum

@main def main() = {
  println( similar_dominos( Seq( (1, 3), (3, 1), (2, 4), (6, 8)         ) ) )
  println( similar_dominos( Seq( (1, 2), (2, 1), (1, 1), (1, 2), (2, 2) ) ) )
}
