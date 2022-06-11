// The Weekly Challenge 158
// Task 1 Additive Primes
// Usage: $ dart ch-1.dart [upper bound, not larger than 1000]
import 'dart:math';

void main(List<String> args) {
  int arg = args.length > 0 && int.parse(args[0]) <= 1000 ? 
                int.parse(args[0]) : 100;
  var small_primes = <int>[2, 3, 5, 7, 11, 13, 17]; // less than 9+9 = 18
  if (arg > 100) small_primes.addAll([19, 23, 29, 31]);
  print("Upper Bound: " + arg.toString());
  var prime = <int>[2];
  LOOP: for (int i = 3; i <= arg; i+=2) {
    for (int k = 0; k < prime.length && prime[k] <= sqrt(i); k++) {
      if (i % prime[k] == 0) continue LOOP;
    }
    prime.add(i);
  }

  for (int j = 0; j < prime.length; j++) {
    int sum = 0;
    var list = prime[j].toString().split("");
    list.forEach( (e) => sum += int.parse(e) );
    var found = small_primes.any( (p) => p == sum );
    if (found) print(prime[j]);
  }
}
