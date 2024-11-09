// https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
// scala3
// scala ch-1.scala
// llcs = length longest consequtive sequence

def llcs( input: Set[Int] ) =
  input
  .filter( x => ! input.contains( x - 1 ) )
  .map( x => (x to Int.MaxValue).takeWhile( input contains _ ).size )
  .map( x => if ( x == 1 ) -1 else x )
  .max

val tests = List(
  ( Set(10, 4, 20, 1, 3, 2),                  4 ),
  ( Set(0, 6, 1, 8, 5, 2, 4, 3, 0, 7),        9 ),
  ( Set(10, 30, 20),                         -1 ),
  ( Set(10, 4, 20, 1, 3, 2, 32,31,33),        4 ),
  ( Set(10, 4, 20, 1, 3, 2, 35,31,34,32,33),  5 )
)

@main def main() = tests.map( (input, expected) => println( if( llcs(input) == expected ) "ok" else "error" ) )
