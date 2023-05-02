#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ ['abc', 'xyz', 'tsu'], 1 ],
 [ ['rat', 'cab', 'dad'], 3 ],
 [ ['baa', 'ill', 'zzy', 'abc' ], 0 ],
 [ ['x', 'y', 'z'],       0 ]
);

my @TESTS2 = (
 [ [ 1, [1,0,0,0,1] ], 1 ],
 [ [ 2, [1,0,0,0,1] ], 0 ],
 [ [ 3, [1,0,0,0,0,0,0,0,1] ], 1 ],
 [ [ 3, [1,0,0,0,0,0,0,0] ], 1],
);

sub non_alpha {
  my $c = 0;
  return 0 if length $_[0] <3;
  for(@_) {
    my($f,$s,@rest)=split//;say $_;
    $f = $f cmp $s;
      ($s ne $_) && ($f ||= $s cmp $_) != ($s cmp $_)
    ? ($c++,last)
    : ($s=$_)           for @rest;
  }
  $c
}

is( non_alpha( @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();
