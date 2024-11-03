//https://theweeklychallenge.org/blog/perl-weekly-challenge-293/
//scala3
//scala ch-2.scala

def is_boomerang( points: Seq[(Int,Int)] ) =
  points
  .sliding(2)
  .map( pair =>
    val dx = pair(1)._1 - pair(0)._1
    val dy = pair(1)._2 - pair(0)._2
    if( dy != 0 ) dx.toFloat / dy.toFloat else 999.0e9        //hm infinity sort of
  )
  .distinct
  .size != 1

@main def main() = {
  List(
    ( Seq( (1, 1), (2, 3), (3,2) ),  true  ),
    ( Seq( (1, 1), (2, 2), (3, 3) ), false ),
    ( Seq( (1, 1), (1, 2), (2, 3) ), true  ),
    ( Seq( (1, 1), (1, 2), (1, 3) ), false ),
    ( Seq( (1, 1), (2, 1), (3, 1) ), false ),
    ( Seq( (0, 0), (2, 3), (4, 5) ), true  )
  )
  .map( (test, expects) => println( "" + expects + (if( is_boomerang( test ) == expects ) " ok" else " error" ) ) )
}
