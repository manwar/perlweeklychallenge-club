// https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
// scala3
// scala ch-2.scala
// function can_make_square for a list of integer stick lengths return true
// if the sticks can make up the sides of a square. It makes use of the
// more general can_make_sums that return true if the sticks can make
// up each of the given sums which in our case is just the side length
// times four. The side length is the sum of all stocks divided by
// four. Function can_make_sums tries each combination of sticks to make
// the first side length and then recursively tries the rest of the stickes
// (lengths) to make up the rest of the side lengths. If the last sum is
// also 0 then the whole list can make up a square.

def can_make_sums( sums: List[Int], lengths: List[Int] ): Boolean =
    if( sums(0) < 0 ) false
    else if( sums(0) == 0 )
        if( sums.size == 1 ) true
        else can_make_sums( sums.tail, lengths )
    else (0 to lengths.size-1).exists(
        x => can_make_sums( sums.patch(0, List(sums(0)-lengths(x)), 1), lengths.patch(x, Nil, 1) ) )

def can_make_square( lengths: List[Int] ): Boolean =
    lengths.sum % 4 == 0
    &&
    can_make_sums( List(lengths.sum/4, lengths.sum/4, lengths.sum/4, lengths.sum/4), lengths )

val tests = List(
  ( List( 1, 2, 2, 2, 1 ),                   true  ),
  ( List( 2, 2, 2, 4 ),                      false ),
  ( List( 2, 2, 2, 2, 4 ),                   false ),
  ( List( 3, 4, 1, 4, 3, 1 ),                true  ),
  ( List( 2, 7, 2, 1, 6, 5, 3, 2, 2, 9, 1 ), true  ),
  ( List( 2, 7, 2, 1, 6, 5, 3, 2, 2, 9, 4 ), false ),
  ( List( 1,2,3,4,5,6,7,8,9,10, 1,2,3,4,5,6,7,8,9,10, 1,2,3,4,5,6,7,8,9,10, 1,2,3,4,5,6,7,8,9,10 ), true ),
  ( (1 to 100).flatMap(List.fill(4)(_)).toList,        true  ),
  ( List( 1,2,3,4,5, 1,2,3,4,5, 1,2,3,4,5, 1,2,3,4,5), true  ),
  ( List( 1,2,3,4,5, 1,2,3,4,5, 1,2,3,4,5, 1,2,3,4,4), false )
)
import scala.util.Random
@main def main() = tests.map( (input, expected)
  => println( if( can_make_square( Random.shuffle(input) ) == expected ) "ok" else "NOT OK" ) )
