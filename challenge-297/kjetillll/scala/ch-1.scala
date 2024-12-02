// https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
// scala3
// scala ch-1.scala
import scala.collection.mutable

def max_len_eq_count_SLOW( l: List[Int] ): Int = {
  val eq = ( for x <- 0 to l.size-1; y <- x+1 to l.size yield l.slice(x,y) ).filter( s => s.sum * 2 == s.size ).map(_.size)
  if( eq.isEmpty ) 0 else eq.max
}
  
def max_len_eq_count_FAST( l: List[Int] ): Int = {
  var s = 0
  var sfsa = mutable.Map( 0 -> -1 )
  l.zipWithIndex.map( (elem,i) => { s += elem * 2 - 1; i - sfsa.getOrElseUpdate(s,i) } ).max
}
  

val tests = List(
  ( List(1, 0), 2 ),
  ( List(0, 1, 0), 2 ),
  ( List(0, 0, 0, 0, 0), 0 ),
  ( List(0, 1, 0, 0, 1, 0), 4 ),
  ( List(0, 1, 0, 1, 0, 0, 1, 0), 6 ),
  ( List(0, 1, 0, 1, 0, 0, 1, 0, 1, 1), 10 ),
  ( (1 to 28).map( x=>Integer.toString(x*771,2)).mkString("").toList.map(_.toInt-48), 238 )
)
@main def main() = tests.map( (input, expected) => {
  var t = System.currentTimeMillis
  def ms = System.currentTimeMillis-t
  println( if( max_len_eq_count_SLOW( input ) == expected ) "ok SLOW: "+ms+"ms" else "NOT OK SLOW" )
  t = System.currentTimeMillis
  println( if( max_len_eq_count_FAST( input ) == expected ) "ok FAST: "+ms+"ms" else "NOT OK FAST" )
}
)
