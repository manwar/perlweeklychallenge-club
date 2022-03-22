#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 7, 1 ],
  [ 6, 0 ],
  [ 8, 1 ],
);

is( is_brazilian($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub is_brazilian {
  O: for my $b (2..($_[0]-2)) {
    my $last = (my $n=$_[0])%$b;
    $n%$b==$last || next O while $n=int($n/$b);
    return 1;
  }
  0;
}

