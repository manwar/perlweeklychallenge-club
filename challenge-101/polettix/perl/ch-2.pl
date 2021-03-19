#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

use Math::Polygon;

sub origin_containing_triangle ($A, $B, $C) {
   Math::Polygon->new($A, $B, $C, $A)->contains([0, 0]) ? 1 : 0;
}

my @pts;
push @pts, [splice @ARGV, 0, 2] while @ARGV;
say origin_containing_triangle(@pts[0..2]);
