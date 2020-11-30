#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

say map { "@{$_}\n" } @{$_} foreach magic();

## We now $e must be 5... so we only need to loop through values 1..9
## for both a and b with possible values such that $c < 10
## the inner loop is then executed just 32 times....

## We can generate all values if we only have a b & e
## If we do this we get the sums of the 2nd and 3rd row as 3e & 30-3e respectively
## For these to both be 15 e must be 5.

sub magic {
  my @solutions = ();
  foreach my $a (1..4,6..9) { ## a can't be 5...
                    ## $b can't be 5, can't be $a and can't make $c 5
    foreach my $b ( grep { $_!=5 && $_!=$a && $a+$_!=10 } ($a<6?6-$a:1)..($a<6?9:14-$a) ) {
      ## Only 32 get here!

      ## Check digits unique and between 1 and 9 { all digits can be computed in terms of a & b }
      my $digits = [ [ $a,         $b,    15-$a-$b   ],
                     [ 20-2*$a-$b, 5,     2*$a+$b-10 ],
                     [ $a+$b-5,    10-$b, 10-$a      ] ];

      ## Convert into the required grid if numbers unique and 1..9
      push @solutions, $digits if '123456789' eq join q(), sort map {@{$_}} @{$digits};
    }
  }
  return @solutions;
}
