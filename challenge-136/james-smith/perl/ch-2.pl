#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 16, 4 ],
  [ 99_999, 192 ],
  [ 9,  2 ],
  [ 15, 2 ],
  [ 8, 3 ],
);
my @fib = (1,2);

is( fib_sum($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();


sub fib_sum {
  my $n = shift;
  push @fib, $fib[-1]+$fib[-2] while $n > $fib[-1];
  return sum( $n, grep { $_ <= $n }  @fib );
}

sub sum {
  local $_;
  my ( $t, @n) = @_;
  return 1 unless $t;
  return 0 if $t < 0;
  my $c = 0;
  $c += sum( $t-$_, @n ) while $_ = shift @n;
  return $c;
}

