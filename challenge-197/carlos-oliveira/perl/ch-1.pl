use strict;
use warnings;

use Data::Dump;

sub moveZero {
  my @listWithoutZeros = grep { $_ != 0 } @_;
  return @listWithoutZeros, (0) x (@_ - @listWithoutZeros);
}

dd moveZero 1, 0, 3, 0, 0, 5;
dd moveZero 1, 6, 4;
dd moveZero 0, 1, 0, 2, 0;

