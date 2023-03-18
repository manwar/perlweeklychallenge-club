#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ [1,2,2,4], [2,3] ],
 [ [1,2,3,4], [-1]  ],
 [ [1,2,3,3], [3,4] ],
 [ [1,2,2,3,5], [2,4] ],
 [ [5,5],       [5,6] ],
);

is( dup_missing( @{$_->[0]} ), $_->[1] ) for @TESTS;

done_testing();

sub dup_missing {
  my($p,$s,$d) = (shift,0);
  ($p==$_ && ($d=$_)),($p=$_,$s+=$_-$f) for @_;
  defined $d ? [ $d, $s2-$s+$d ] : [ -1 ];
}
