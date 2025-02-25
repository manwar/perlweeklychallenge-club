// https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
// scala3
// scala ch-2.scala
// Next lexicographically greater permutation
// Adapted Fischer-Krause algorithm

def next_permutation( i: Array[Int] ): Array[Int] = {
  var p = i.size - 1
  while( p > 0 && i(p-1) > i(p) ){ p -= 1 }
  if( p == 0 ) return Array[Int]()
  val(a1, a2) = i.splitAt(p)
  val a = a1 ++ a2.reverse
  var q = p
  while( a(p-1) > a(q) ){ q+=1 }
  val swap = a(p-1)
  a(p-1) = a(q)
  a(q) = swap
  a
}

val tests = Array(
  (Array(1, 2, 3), Array(1, 3, 2)),
  (Array(2, 1, 3), Array(2, 3, 1)),
  (Array(3, 1, 2), Array(3, 2, 1)),
  (Array(3, 2, 1), Array[Int]()),
  (Array(6,3,9,8,7,5,4,2,1), Array(6,4,1,2,3,5,7,8,9)),
  (Array(9,5,6,1,8,7,4,3,2), Array(9,5,6,2,1,3,4,7,8)),
  (Array(17,22,16,6,11,23,12,4,19,14,13,18,25,1,7,24,21,20,15,10,9,8,5,3,2),
    Array(17,22,16,6,11,23,12,4,19,14,13,18,25,1,8,2,3,5,7,9,10,15,20,21,24))
)

@main def main() = tests.map( (input, expected) => println( if( next_permutation(input).mkString(" ") == expected.mkString(" ") ) "ok" else "error" ) )
