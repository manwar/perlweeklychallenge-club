#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ [ 1, [1,0,0,0,1] ], 1 ],
 [ [ 2, [1,0,0,0,1] ], 0 ],
 [ [ 3, [1,0,0,0,0,0,0,0,1] ], 1 ],
 [ [ 3, [1,0,0,0,0,0,0,0] ], 1],
);

sub insert_zero {
  my($s,$c) = (0,shift);
  $_ ? ( $c-= $s>2 && int( ($s-1)/2 ), $s=0 ) : $s++ for @_,1;
  $c>0?0:1;
}

sub insert_zero_simultaneous {
  my($s,$c) = (0,shift);
  $_ ? ( $c-= $s>2 && $s-2, $s=0 ) : $s++ for @_,1;
  $c>0?0:1
}

sub insert_zero_shortcut {
   my($s,$c) = (0,shift);
   $_ ? ( $c-= $s>2 &&  int(($s-1)/2), $s=0, $c>0 || return 1 ) : $s++ for @_,1;
   0;
}

sub insert_zero_simultaneous_shortcut {
  my($s,$c) = (0,shift);
  $_ ? ( $c-= $s>2 && $s-2, $s=0, $c>0 || return 1 ) : $s++ for @_,1;
  0;
}

is( insert_zero( $_->[0][0], @{$_->[0][1]} ), $_->[1] ) for @TESTS;
is( insert_zero_simultaneous( $_->[0][0], @{$_->[0][1]} ), $_->[1] ) for @TESTS;
is( insert_zero_shortcut( $_->[0][0], @{$_->[0][1]} ), $_->[1] ) for @TESTS;
is( insert_zero_simultaneous_shortcut( $_->[0][0], @{$_->[0][1]} ), $_->[1] ) for @TESTS;

done_testing();
