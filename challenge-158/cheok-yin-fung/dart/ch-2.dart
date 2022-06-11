// The Weekly Challenge 158
// Task 2 Cuban Primes
// Usage: $ dart ch-2.dart [Upper bound]
// using Wheel Factorization (though seems that it is better for sieve...)
// check result with OEIS:A002407
import 'dart:math';

void main(List<String> args) {
  int arg = args.length > 0 ? int.parse(args[0]) : 1000;
  List rp_to_30 = <int>[1, 7, 11, 13, 17, 19, 23, 29]; 
  int y = 3;
  int pp = 37;
  if (7 <= arg) print(7);
  if (19 <= arg) print(19);
  List spokes = <int>[];
  for (int i = 1; i < rp_to_30.length; i++)
    spokes.add( rp_to_30[i] );  // skip 1
  while (pp <= arg) {
    if (pp % 5 == 0) continue;  // pp must be coprime to 2 and 3.
    if (spokes.last < sqrt(pp)) {
      var k = ((spokes.last+1)/30).floor();
      rp_to_30.forEach( (e) => spokes.add(e+k*30) );
    }
    y++;
    if (spokes.any( (d) => pp % d == 0 )) {
      pp = 3*y*y + 3*y + 1;
      continue;
    } else {
      print(pp.toString());
      pp = 3*y*y + 3*y + 1;
    }
  }
} 
