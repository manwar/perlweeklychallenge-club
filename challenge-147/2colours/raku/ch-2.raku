#!/usr/bin/env raku

sub is-pentagon($c) { (1+sqrt(1+24*$c))%%6 }

sub P($n) { $n*(3*$n-1) div 2 #`(make rationals faster, pretty please) }

OUTSIDE:
for 1..Inf -> $bigger {
  for 1..^$bigger -> $smaller {
    my $bigger-p = P($bigger);
    my $smaller-p = P($smaller);
    #my ($bigger-p, $smaller-p) = (P($bigger), P($smaller)); eliminate the runtime overhead of this destructuring, pretty please 
    if is-pentagon($bigger-p + $smaller-p) && is-pentagon($bigger-p - $smaller-p) {
      say "P($bigger)=$bigger-p and P($smaller)=$smaller-p";
      last OUTSIDE;
    }
  }
}
