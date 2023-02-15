use strict;
use warnings;
use v5.36;

use Test::More;

sub count_special_quadruplets {
  my $quadruplet_count = 0;
  for my $a (0 .. $#_ - 3) {
    for my $b ($a + 1 .. $#_ - 2) {
      for my $c ($b + 1 .. $#_ - 1) {
        for my $d ($c + 1 .. $#_) {
          $quadruplet_count++ if $_[$a] + $_[$b] + $_[$c] == $_[$d];
        }
      }
    }
  }
  return $quadruplet_count;
}

is count_special_quadruplets(1,2,3,6),    1;
is count_special_quadruplets(1,1,1,3,5),  4;
is count_special_quadruplets(3,3,6,4,5),  0;

done_testing;
