// https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
// scala3
// scala ch-2.scala

def min_swaps( l: List[Int] ): Int = {
  val i1 = l.indexOf(1)
  val iN = l.indexOf(l.size)
  val swaps_to_move_1 = i1
  val swaps_to_move_N = l.size - 1 - iN
  val discount_for_already_swapped_1_and_N = if( i1 > iN ) -1 else  0
  swaps_to_move_1 + swaps_to_move_N + discount_for_already_swapped_1_and_N
}
  

val tests = List(
  ( List(2, 1, 4, 3), 2 ),
  ( List(2, 4, 1, 3), 3 ),
  ( List(1, 3, 2, 4, 5), 0 ),
  ( List(22,24,10,34,35,8,13,21,30,6,3,29,17,12,16,4,19,40,15,9,18,28,14,23,31,2,33,27,36,20,26,39,11,25,1,32,37,7,5,38), 55),
  ( List(17,26,31,5,12,9,6,24,35,29,21,22,1,20,33,15,2,28,38,34,25,30,16,27,36,7,37,19,32,40,4,3,8,10,23,14,11,39,13,18), 22),
)
@main def main() = tests.map( (input, expected) => println( if( min_swaps( input ) == expected ) "ok" else "NOT OK" ) )
