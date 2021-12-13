#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ '10 + 20 - 5', 25 ],
  [ '(10 + 20 - 5) * 2', 50 ],
  [ '(5 - 10) * -5', 25 ],
  [ '10 * 10 - 6 * 6 - 8 * 8', 0 ],
  [ '4 + 4 - 6 - 2', 0 ],
  [ '(10 + 10) * (10 - 10) * (10 + 10) * (20 - (((20))))', 0 ],
);

is( evaluate($_->[0]), $_->[1] ) foreach @TESTS;
is( eval(    $_->[0]), $_->[1] ) foreach @TESTS;
cmpthese( 20000, {
  'evaluate' => sub { evaluate($_->[0]) for @TESTS },
  'eval'     => sub { eval(    $_->[0]) for @TESTS },
});
done_testing();

sub evaluate  {
  my $str = shift;
  1 while $str =~ s/\(\s*([^()]*?)\s*\)/       evaluate($1)             /e;
  1 while $str =~ s/(-?\d+)\s*\*\s*(-?\d+)/    $1 * $2                  /e;
  1 while $str =~ s/(-?\d+)\s*([-+])\s*(-?\d+)/$2 eq '+' ? $1+$3 : $1-$3/e;
  return $str;
}

