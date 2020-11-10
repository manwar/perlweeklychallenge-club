#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

say n_rev( @ARGV );

sub n_rev {
  my $n = shift;
  return @_>0                         ? 0
       : ! defined $n                 ? 0
       : $n !~ m{\A-?\d+\Z}           ? 0
       : $n <= -(1<<31) || $n > 1<<31 ? 0
       : $n < 0                       ? -reverse split m{}, -$n
       :                                1*reverse split m{}, $n
       ;
}
