#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $MAX         = 1e9;
my $MAX_LARGE   = 40;
my $COUNT = 500;
my @TESTS = (
  [ 56, 0 ],
  [ 57, 0 ],
  [ 59, 0 ],
  [196, 1 ],
);

is( lychrel(      $_->[0]), $_->[1] ) foreach @TESTS;
is( lychrel_large($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub lychrel {
  my($n,$c) = (shift,$COUNT);
  ($n eq reverse $n) ? (return 0) : ($n+= reverse $n) while $c-- && $n <= $MAX;
  1;
}

sub lychrel_large {
  my($n,$c) = (shift,$COUNT);
  my @n = split //, $n;
  while( $c-- && @n <= $MAX_LARGE ) {
    my @r = reverse @n;
    return 0 if (join '', @r) eq (join '', @n);
    foreach ( reverse 0 .. @n-1 ) {
      $n[$_] += $r[$_];
      next if $n[$_] < 10;
      $n[$_]-=10;
      $_ ? ($n[$_-1]++) : (unshift @n,1);
    }
  }
  1;
}


print "Simple:";
print " $_" foreach grep { lychrel $_ } 10..1000;
print "\nLarge: ";
print " $_" foreach grep { lychrel_large $_ } 10..1000;
print "\n\n";

