#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @list1 = ( 'bob', map { chr(97+rand(26)) x 3 } 1..10000 );
my @list2 = (      ( map { chr(97+rand(26)) x 3 } 1..10000 ), 'bob' );
my @TESTS = (
  [ [qw(adc wzy abc)],     'abc' ],
  [ [qw(aaa bob ccc ddd)], 'bob' ],
  [ [@list1],              'bob' ],
  [ [@list2],              'bob' ],
);

is( odd_string_array( @{$_->[0]} ), $_->[1] ) for @TESTS;
is( odd_string_fast(  @{$_->[0]} ), $_->[1] ) for @TESTS;

sub odd_string_array {
  my %x;
  ## Keyed by signature - so one key will have
  push @{$x{
      ord( substr $_, 1 ) *  99
    + ord( substr $_, 2 )
    - ord( $_           ) * 100
  }}, $_ for @_;
  [ grep { @{$_}==1 } values %x ]->[0][0]
}

sub odd_string_fast {
  my($x1,$x2,$y1,$y2,$z1,$z2) = (
    ord($_[0]) - ord(substr$_[0],1), ord($_[0]) - ord(substr$_[0],2),
    ord($_[1]) - ord(substr$_[1],1), ord($_[1]) - ord(substr$_[1],2),
    ord($_[2]) - ord(substr$_[2],1), ord($_[2]) - ord(substr$_[2],2),
  );
  if( $x1 == $y1 && $x2 == $y2 ) { ## First & second match so NOT 1st
    if( $x1 == $z1 && $x2 == $z2 ) { ## Third matches first - so find first which doesn't
      ( $x1 != ord($_) - ord(substr$_,1) || $x2 != ord($_) - ord(substr$_,2) ) && return $_ for @_[3..$#_];
    } else {
      return $_[2];
    }
  } ## Different so it must be 1st or ceons
  $_[ $x1 == $z1 && $x2 == $z2 ? 1 : 0 ]
}


