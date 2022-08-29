#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 'Perl Weekly Challenge', 0 ],
  [ 'Long Live Perl',        1 ],
);

is( first_unique($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub first_unique {
  my( @p, $last, %seen ) = split //, pop;
  ( $seen{ $p[$_] } ++ ) || ( $last = $_ ) for reverse 0 .. $#p;
  $last;
}

