#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## List of brazillian numbers... for testing...
my %T = map { $_ => 1 } qw(
                     7  8    10    12 13 14 15 16    18     20
  21 22    24    26 27 28    30 31 32 33 34 35 36    38 39  40
     42 43 44 45 46    48    50 51 52    54 55 56 57 58     60
     62 63 64 65 66    68 69 70    72 73 74 75 76 77 78     80
  81 82    84 85 86 87 88    90 91 92 93 94 95 96    98 99 100
);

is( is_brazilian( $_ ), $T{$_}||0 ) for 4..100;

done_testing();

sub is_brazilian {
  O: for my $b ( 2 .. $_[0]/2 - 1 ) {
    my $l = (my $n=$_[0]) % $b;
    $n % $b == $l || next O while $n = int($n/$b);
    return 1;
  }
  0;
}

