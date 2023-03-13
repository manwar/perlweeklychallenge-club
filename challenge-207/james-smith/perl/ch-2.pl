#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS =  (
 [ [10,8,5,4,3], 4 ],
 [ [25,8,5,3,3], 3 ],
);

is( h_index(   @{$_->[0]} ), $_->[1] ) for @TESTS;
is( h_index_2( @{$_->[0]} ), $_->[1] ) for @TESTS;
is( h_index_3( @{$_->[0]} ), $_->[1] ) for @TESTS;

done_testing();

sub h_index        { ( $_[$_]>$_) && return $_+1 for reverse 0..$#_ }
sub h_index_2      { pop @_ while $_[-1] < @_; 0 + @_               }
sub h_index_3      { ( $_[$_]>$_) || return $_ for 0..$#_; 0+@_     }
