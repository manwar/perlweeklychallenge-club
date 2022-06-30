#!/usr/bin/env raku

sub divisors($num) {                                                    
  my @small-divisors = (1 .. sqrt $num).grep: $num %% *;                      
  (|@small-divisors, |($num <<div<< @small-divisors )).Set
}

1, 3 ... * andthen
  .grep: { .&divisors.keys.sum > 2 * $_ } andthen
  .head: 20 andthen
  .join: ', ' andthen
  .say;
