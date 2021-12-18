#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @ST = qw(
   4   12   24   36   40   60   72   84  112  120  144  180
 220  240  252  264  312  336  360  364  400  420  432  480
 504  540  544  600  612  660  672  684  760  792  840  864
 900  924  936 1012 1080 1092 1104 1120 1200 1260 1300 1320
);
my @NST = map { $_ + 15 } @ST;
my @TESTS = (
  ( map { [$_ => 1] } @ST  ),
  ( map { [$_ => 0] } @NST ),
);

is( stealthy_number($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub stealthy_number {
  my($n,%c) = shift;
  $n%$_||($c{$n/$_+$_ }++,$c{$n/$_+$_+1}++) for 1..sqrt$n;
  (grep { $_ > 1 } values %c) ? 1 : 0;
}

