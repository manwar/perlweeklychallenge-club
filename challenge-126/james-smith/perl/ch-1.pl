#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 15, 8 ],
  [ 25, 13 ],
  [ 100, 80 ],
  [ 1000, 728 ],
  [ 1100, 728 ],
  [ 1200, 728 ],
  [ 1300, 728 ],
  [ 2000, 729 ],
  [ 2100, 809 ],
  [ 2200, 810 ],
  [ 3000, 1458 ],
  [ 4000, 2187 ],
  [ 5000, 2916 ],
  [ 10000, 6560 ],
  [ 20000, 6561 ],
  [ 25000, 6561+2916 ],
  [ 25500, 6561+2916+324 ],
  [ 25540, 6561+2916+324+27 ],
  [ 25543, 6561+2916+324+27+2 ],
  [ 100000, 59048 ],
  [ 1000000, 531440  ],
);

# warn "@{$_} -> ", get_no_one_count_x($_->[0]), "\n" foreach @TESTS;

is( get_no_one_count_x($_->[0]), $_->[1] ) foreach @TESTS;
is( get_no_one_count($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

sub get_no_one_count {
  my $n = shift;
  return scalar grep { ! m{1} } 2..$n;
}

## Optimized version.... seems to work ... and far better than scan...
sub get_no_one_count_x {
  my $n = shift;
  my $c = 0;
  my $m = 1;
  while($n) {
    my $t=$n%10;
    $c = 0 if $t==1;
    $c += $t ? ( $t < 2 ? ($m-1) : ($t-1)*$m ) : 0;
    $m *= 9;
    $n= int($n/10);
  }
  return $c;
}

