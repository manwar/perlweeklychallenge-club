#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ '978-0-306-40615-7' , 1 ],
  [ '978-3-16-148410-0',  1 ],
  [ '978-0-306-40615-3' , 0 ],
  [ '978-3-16-148410-4',  0 ],
);

is( validate_isbn13($_->[0]) || 0, $_->[1] ) foreach @TESTS;

done_testing();

sub validate_isbn13 {
  my( $s, @p ) = ( 0, grep {/\d/} split //, $_[0] );
  $s -= shift(@p) + 3*shift @p for 0..5;
  $p[0] == $s%10;
}

